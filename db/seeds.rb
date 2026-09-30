# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create({"first_name" => "Marc", "last_name" => "Hoeppner", "email_address" => "marc.hoeppner@lsh.landsh.de", "password_digest" => "$2b$05$WyEpT28Ib84kmlZLc8AvUuHvjNZHwxHBCsUJRxDm8YBuNf0vcgYoy"})
# Test123

Platform.create({"name" => "Illumina"})

Pipeline.create(
    {"name" => "FooDMe2 1.5. Meat", 
    "description" => "FooDMe2 Pipeline für Fleischprodukte", 
    "version" => "1.5", 
    "template" => "/work_syn/shared/software/nextflow/nextflow run bio-raum/FooDMe2 --primer_set amniotes_dobrovolny --blast_min_consensus 0.6",
    "samplesheet_format" => "sample\tfq1\tfq2" 
    }
)

Pipeline.create(
    {"name" => "ReadQC 1.3",
    "description" => "Run QC",
    "version" => "1.3",
    "template" => "/work_syn/shared/software/nextflow/nextflow run marchoeppner/read-qc",
    "run_level" => true,
    "job_level" => false
    }
)

Pipeline.create(
    { "name" => "Backup v1",
    "description" => "Backup a run folder",
    "version" => 1, 
    "run_level" => true,
    "job_level" => false,
    "template" => "/work_syn/shared/scripts/backup_run_folder"
    }
)