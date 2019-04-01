class Material < ApplicationRecord
  FUNCTIONS = [
    "conductive", "dielectric", "soldermask", "stiffener", "final_finish",
  ]
  GROUPS = [
    "FR1", "FR2", "FR3", "FR4", "FR5", "G-10", "G-11", "CEM-1", "CEM-2", "CEM-3", "CEM-4", "CEM-5", "ceramic", "polyimide", "aramid", "acrylic", "LCP", "PEN", "PET", "LPISM", "DFISM", "LDISM", "stainless_steel", "copper", "aluminum", "silver", "gold", "carbon", "silver_platinum", "silver_paladium", "gold_platinum", "platinum", "c_bare_copper", "isn", "iag", "enig", "enepig", "osp", "ht_osp", "g", "GS", "t_fused", "tlu_unfused", "dig", "gwb-1_ultrasonic", "gwb-2-thermosonic", "s_hasl", "b1_lfhasl", "IMS",
  ]
  UL = ["v-0", "v-1", "hb"]
  RESIN = ["epoxy", "bt", "cyanate_ester", "phenolic", "polyester", "polyimide", "ppe", "hydrocarbon", "ptfe", "thermoplastic"]
  RETARDANT = ["phosphor", "red_phosphor", "bromine", "chlorine", "antimony_oxide", "rohs_compliant_bromine"]
  FILLER = ["ceramic", "kaolin", "organic", "inorganic", "glass"]
  REINFORCEMENT = ["e-glass", "s-glass", "ne-glass", "l-glass", "quartz", "aramid", "paper"]
  FOIL_ROUGHNESS = ["L", "S", "V"]
  IPC_840 = ["T", "H", "TF", "HF"]
  FINISH = ["matte", "glossy", "semi_glossy"]

  belongs_to :manufacturer, optional: true

  validates :function, inclusion: { in: FUNCTIONS }, allow_nil: true
  validates :group, inclusion: { in: GROUPS }, allow_nil: true
  validates :ul_94, inclusion: { in: UL }, allow_nil: true
  validates :resin, inclusion: { in: RESIN }, allow_nil: true
  validates :flame_retardant, inclusion: { in: RETARDANT }, allow_nil: true
  validates :reinforcement, inclusion: { in: REINFORCEMENT }, allow_nil: true
  validates :foil_roughness, inclusion: { in: FOIL_ROUGHNESS }, allow_nil: true
  validates :ipc_sm_840_class, inclusion: { in: IPC_840 }, allow_nil: true
  validates :finish, inclusion: { in: FINISH }, allow_nil: true
  validate :filler_values

  before_validation :normalize_blank_values

  private

  def normalize_blank_values
    attributes.each do |column, value|
      unless self[column].present?
        self[column] = nil
      end
    end
  end

  def filler_values
    return if filler.nil?
    unless filler.all? { |f| FILLER.include?(f) }
      errors.add(:filler, :inclusion)
    end
  end
end
