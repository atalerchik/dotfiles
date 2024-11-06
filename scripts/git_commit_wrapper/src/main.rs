use std::process::Command;
use std::fs::{OpenOptions, create_dir_all};
use std::io::Write;
use chrono::Local;
use std::path::Path;
use std::env;

fn main() {
    // Получаем домашнюю директорию пользователя
    let home_dir = env::var("HOME").expect("Не удалось получить домашнюю директорию");
    
    // Создаем директорию для отчетов, если она не существует
    let report_dir = format!("{}/.daily_reports", home_dir);
    if !Path::new(&report_dir).exists() {
        create_dir_all(&report_dir).expect("Не удалось создать директорию для отчетов");
    }

    // Получаем текущую дату
    let current_date = Local::now();

    // Формируем имя файла отчета
    let report_file_name = format!(
        "daily_report_{}.md",
        current_date.format("%d_%m_%Y")
    );

    // Путь к файлу отчета
    let report_file = format!("{}/{}", report_dir, report_file_name);

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

    // Получаем хеш последнего коммита
    let output = Command::new("git")
        .args(&["rev-parse", "HEAD"])
        .output()
        .expect("Не удалось выполнить git команду");

    let commit_hash = String::from_utf8_lossy(&output.stdout).trim().to_string();

    // Формируем запись для отчета в формате Markdown
    let report_entry = format!(
        "## Коммит от {}\n\n**Хеш коммита:** `{}`\n\n**Сообщение коммита:**\n{}\n\n**Измененные файлы:**\n{}\n\n---\n\n",
        current_time.format("%Y-%m-%d %H:%M:%S"),
        commit_hash,
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

