namespace :db do
  desc "This is to migrate old data to be compatible with the new functionalities"
  task add_function_and_group: :environment do
    # Code here
    Function.where(name: "conductive", description: "Type of material that allows the flow of an electrical current in one or more directions. Materials made of metal are common electrical conductors. Examples are Copper, Gold").first_or_create
    Function.where(name: "dielectric", description: "A dielectric (or dielectric material) is an electrical insulator that can be polarized by an applied electric field.").first_or_create
    Function.where(name: "soldermask", description: "Solder mask or solder stop mask or solder resist is a thin lacquer-like layer of polymer that is usually applied to the copper traces of a printed circuit board (PCB) for protection against oxidation and to prevent solder bridges from forming between closely spaced solder pads.").first_or_create
    Function.where(name: "stiffener", description: "Stiffeners are materials added to a flex circuit to rigidize particular areas.").first_or_create
    Function.where(name: "final_finish", description: "To save good solderability of PCBs, flatness of the surface, solid montage of electronic components and solder connections of PCB it is necessary to protect cooper pads with final finish.").first_or_create
    Group.where(name: "FR1", description: "FR-1 is a hard, flat material that consists of a thin layer of copper over a non- conductive phenolic resin.").first_or_create
    Group.where(name: "FR2", description: "FR-2 (Flame Resistant 2) is a NEMA designation for synthetic resin bonded paper, a composite material made of paper impregnated with a plasticized phenol formaldehyde resin, used in the manufacture of printed circuit boards.").first_or_create
    Group.where(name: "FR3", description: "FR3 is also basically FR2. But instead of phenolic resin it uses an epoxy resin binder.").first_or_create
    Group.where(name: "FR4", description: "FR-4 (or FR4) is a NEMA grade designation for glass-reinforced epoxy laminate material. FR-4 is a composite material composed of woven fiberglass cloth with an epoxy resin binder that is flame resistant (self-extinguishing).").first_or_create
    Group.where(name: "FR5", description: "NEMA grades G11 and FR5 Glass-Cloth Reinforced Epoxy - natural color is typically yellow green to amber. This grade is similar to G10/FR4 but has a higher operating temperature and superior mechanical properties at elevated temperatures.").first_or_create
    Group.where(name: "CEM-1", description: "CEM-1 is low-cost, flame-retardant, cellulose-paper-based laminate with only one layer of woven glass fabric.").first_or_create
    Group.where(name: "CEM-2", description: "CEM-2 has cellulose paper core and woven glass fabric surface.").first_or_create
    Group.where(name: "CEM-3", description: "CEM-3 is very similar to the most commonly used PCB material, FR-4. Its color is white, and it is flame-retardant.").first_or_create
    Group.where(name: "CEM-4", description: "CEM-4 quite similar as CEM-3 but not flame-retardant.").first_or_create
    Group.where(name: "CEM-5", description: "CEM-5 (also called CRM-5) has polyester woven glass core.").first_or_create
    Group.where(name: "ceramic", description: "FR3 is also basically FR2. But instead of phenolic resin it uses an epoxy resin binder.").first_or_create
    Group.where(name: "polyimide", description: "FR3 is also basically FR2. But instead of phenolic resin it uses an epoxy resin binder.").first_or_create
    Group.where(name: "aramid", description: "Aramid.").first_or_create
    Group.where(name: "acrylic", description: "Acrylic.").first_or_create
    Group.where(name: "LCP", description: "LCP.").first_or_create
    Group.where(name: "PEN", description: "PEN.").first_or_create
    Group.where(name: "PET", description: "PET.").first_or_create
    Group.where(name: "LPISM", description: "LPISM.").first_or_create
    Group.where(name: "DFISM", description: "DFISM.").first_or_create
    Group.where(name: "LDISM", description: "LDISM.").first_or_create
    Group.where(name: "stainless_steel", description: "Stainless steel.").first_or_create
    Group.where(name: "copper", description: "Copper.").first_or_create
    Group.where(name: "aluminum", description: "Aluminum.").first_or_create
    Group.where(name: "silver", description: "Silver.").first_or_create
    Group.where(name: "gold", description: "gold.").first_or_create
    Group.where(name: "carbon", description: "Carbon.").first_or_create
    Group.where(name: "silver_platinum", description: "Silver platinum.").first_or_create
    Group.where(name: "silver_paladium", description: "Silver paladium.").first_or_create
    Group.where(name: "gold_platinum", description: "Gold platinum.").first_or_create
    Group.where(name: "platinum", description: "Platinum.").first_or_create
    Group.where(name: "c_bare_copper", description: "Bare copper.").first_or_create
    Group.where(name: "isn", description: "Isn.").first_or_create
    Group.where(name: "iag", description: "Iag.").first_or_create
    Group.where(name: "enig", description: "Enig.").first_or_create
    Group.where(name: "enepig", description: "Enepig.").first_or_create
    Group.where(name: "osp", description: "Osp.").first_or_create
    Group.where(name: "ht_osp", description: " HT Osp.").first_or_create
    Group.where(name: "g", description: "G.").first_or_create
    Group.where(name: "GS", description: "GS.").first_or_create
    Group.where(name: "t_fused", description: "T fused.").first_or_create
    Group.where(name: "tlu_unfused", description: "TLU unfused.").first_or_create
    Group.where(name: "dig", description: "Dig.").first_or_create
    Group.where(name: "gwb-1_ultrasonic", description: "gwb-1 ultrasonic.").first_or_create
    Group.where(name: "gwb-2_thermosonic", description: "gwb-2 thermosonic.").first_or_create
    Group.where(name: "s_hasl", description: "S hasl.").first_or_create
    Group.where(name: "b1_lfhasl", description: "b1 lfhasl.").first_or_create
    Group.where(name: "IMS", description: "IMS placeholder until further clarification.").first_or_create
    # Update exiting materials and add group_id and function_id
    Material.all.each do |m|
      #if m.group_id == nil and m.function_id == nil
      if m.attributes["group"] and m.attributes["function"]
        puts m.id
        puts m.function
        m.update(group_id: Group.find_by_name(m.attributes["group"]).id, function_id: Function.find_by_name(m.attributes["function"]).id)
      elsif m.group
        m.update(group_id: Group.find_by_name(m.attributes["group"]).id)
      elsif m.function
        m.update(function_id: Function.find_by_name(m.attributes["function"]).id)
      end
      #end
    end
  end

  private
end
