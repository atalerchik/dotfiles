use std::process::Command;
use std::fs::{OpenOptions, create_dir_all};
use std::io::Write;
use chrono::Local;
use std::path::Path;

fn main() {
    // Получаем корневую директорию репозитория
    let output = Command::new("git")
        .args(&["rev-parse", "--show-toplevel"])
        .output()
        .expect("Не удалось выполнить git команду");

    let repo_root = String::from_utf8_lossy(&output.stdout).trim().to_string();

    // Путь к файлу отчета
    let report_dir = format!("{}/.git_reports", repo_root);
    let report_file = format!("{}/daily_report.txt", report_dir);

    // Создаем директорию для отчетов, если она не существует
    if !Path::new(&report_dir).exists() {
        create_dir_all(&report_dir).expect("Не удалось создать директорию для отчетов");
    }

    // Получаем сообщение последнего коммита
    let output = Command::new("git")
        .args(&["log", "-1", "--pretty=%B"])
        .output()
        .expect("Не удалось выполнить git команду");

    let commit_message = String::from_utf8_lossy(&output.stdout).trim().to_string();

    // Получаем список измененных файлов
    let output = Command::new("git")
        .args(&["diff-tree", "--no-commit-id", "--name-only", "-r", "HEAD"])
        .output()
        .expect("Не удалось выполнить git команду");

    let changed_files = String::from_utf8_lossy(&output.stdout)
        .lines()
        .map(|s| format!("- {}", s))
        .collect::<Vec<String>>()
        .join("\n");

    // Получаем текущее время
    let current_time = Local::now();

    // Формируем запись для отчета
    let report_entry = format!(
        "==============================\nДата: {}\nСообщение коммита: {}\nИзмененные файлы:\n{}\n\n",
        current_time.format("%Y-%m-%d %H:%M:%S"),
        commit_message,
        changed_files
    );

    // Открываем или создаем файл отчета
    let mut file = OpenOptions::new()
        .create(true)
        .append(true)
        .open(&report_file)
        .expect("Не удалось открыть файл");

    // Записываем информацию в файл
    if let Err(e) = file.write_all(report_entry.as_bytes()) {
        eprintln!("Не удалось записать в файл: {}", e);
    }
}

