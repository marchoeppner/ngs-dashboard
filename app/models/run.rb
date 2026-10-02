class Run < ApplicationRecord
  belongs_to :platform
  has_many :libraries, dependent: :destroy
  has_many :jobs, dependent: :destroy

  paginates_per 25

  def register_libraries
    platform = self.platform

    fastqs = Dir["#{self.location}/**/*.fastq.gz"].group_by { |f| File.basename(f).split(/_L00[0-9]/).first }

    fastqs.each do |library, reads|
      acc = library
      name = library

      reads.group_by { |r| File.basename(r).slice(/L[0-9]*/) }.each do |b, reads|
        puts reads.inspect
        lane = b.split("L00").last
        fwd = nil
        rev = nil
        if reads.length == 2
          fwd, rev = reads
        else
          fwd = reads.first
        end

          # if Library.where(R1: fwd, run_id: self.id, lane: lane).empty?
          lib = Library.create({ "accession" => acc, "name" => name, "R1" => fwd, "R2" => rev, "run_id" => self.id, "lane" => lane, "platform_id" => platform.id })
          lib.save
        # end
      end
    end
  end

  def clean_name
    self.name.gsub(/\s+/, "_")
  end

  def count_unique_libraries
    self.libraries.map { |l| l.name }.uniq.length
  end
end
