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

  def yield
    qc_json&.dig('interop', 'total', 'Yield')&.to_f
  end

  def phix_aligned
    qc_json&.dig('interop', 'total', 'Aligned')&.to_f
  end

  def phix_error
    qc_json&.dig('interop', 'total', 'Error Rate')&.to_f
  end

  # 1. Metric: Read 1 Q30
  def read_1_q30
    qc_json&.dig('interop', 'read_1', '%>=Q30')&.to_f
  end

  def read_1_q30=(value)
    initialize_nested_structure('read_1')
    qc_json['interop']['read_1']['%>=Q30'] = value.to_s
  end

  # 2. Metric: Read 4 Q30
  def read_4_q30
    qc_json&.dig('interop', 'read_4', '%>=Q30')&.to_f
  end

  def read_4_q30=(value)
    initialize_nested_structure('read_4')
    qc_json['interop']['read_4']['%>=Q30'] = value.to_s
  end

  def total_q30
    qc_json&.dig('interop', 'total', "%>=Q30")&.to_f
  end
  
  # 3. Metric: Total Yield
  def total_yield
    qc_json&.dig('interop', 'total', 'Yield')&.to_f
  end

  def total_yield=(value)
    initialize_nested_structure('total')
    qc_json['interop']['total']['Yield'] = value.to_s
  end

  def clean_name
    self.name.gsub(/\s+/, "_")
  end

  def count_unique_libraries
    self.libraries.map { |l| l.name }.uniq.length
  end

  private

  # Helper method to safely initialize the nested Hash structure without overwriting existing keys
  def initialize_nested_structure(read_key)
    self.qc_json ||= {}
    self.qc_json['interop'] ||= {}
    self.qc_json['interop'][read_key] ||= {}
  end

end
