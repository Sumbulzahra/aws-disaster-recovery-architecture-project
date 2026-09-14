import os
import shutil
import datetime

# Configuration
SOURCE_DIR = "/production-data"
BACKUP_DIR = "/var/backups/production-data"

def create_backup():
    # Ensure backup directory exists
    if not os.path.exists(BACKUP_DIR):
        os.makedirs(BACKUP_DIR)
        
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_filename = os.path.join(BACKUP_DIR, f"backup_{timestamp}")
    
    try:
        print(f"Starting backup of {SOURCE_DIR}...")
        shutil.make_archive(backup_filename, 'zip', SOURCE_DIR)
        print(f"Backup successfully created: {backup_filename}.zip")
    except Exception as e:
        print(f"Error during backup process: {e}")

if __name__ == "__main__":
    create_backup()
