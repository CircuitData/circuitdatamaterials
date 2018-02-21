# CircuitData Material Database
 CircuitData.org offers a database, primarily designed for developers, that will hold material data relevant for printed circuits. The purpose of the database is to present data from different sources having one generic structure compatible with the CircuitData language

## Version
Current version is 0.1. This should be stated in every section directly above the "name" element in an element called "version".

## Usage through the CircuitDataMaterials API 
The Material database will be accessible through API-only, and there will be no User Interface rolled out as part of the solution. The database is read-only and will collect material information from sources approved by the CircuitData board of directors. Approved sources will be listed below

### COMMODITY.LIVE
COMMODITY.LIVE is developed by Elmatica and sister company NTTY. Through COMMODITY.LIVE Elmatica will populate the Material Database with their existing data and ensure that is available for everyone. The data in the Material Database is updated on a daily basis from the source of origin.

## Technical Structure
The database will be open and reachable through API-calls to a hosted application. Any developer can use RESTFUL-API calls to collect harmonised and unique data about materials and use this data in their own solutions. The solution is developed using Restful JSON API with Rails 5.

The Database structure has 4 models, Material, MaterialAttributes, MaterialAttributeValues and Manufacturer. These four models will hold all the data needed to cover the Materials related to PCB fabrication. The API will allow direct access to:
- A list of manufacturers and their materials
- One specific manufacturer and their materials
- A list of materials and their manufacturer and material attributes and values
- One specific material with its manufacturer and material attributes and values

It is possible to extract data based on a set of parameters with the intention of providing relevant data to each users requirements. These will evolve as needed based on feedback from users.

The JSON response will be in format that is compatible with the CircuitData language.

### Possible extracts
- A list of all materials based on their function (dielectric, soldermask etc. )
- A list of all materials based on their group (FR4, etc. )

### Hosted environment
[CircuitDataMaterials API](https://circuitdatamaterials.herokuapp.com/) 
[Documentation on the usage of the API](https://restless-rocket-4633.postman.co/collections/2082658-be97e341-a76a-3f01-4d97-509adf66a6c9)

## Basic example
This example shows how the material is structured when pulled from the Material Database through our API.
```
{
    "name": "TU-865",
    "verified": null,
    "id": "5acad4c0-162e-41fb-8698-893e09fc8f7f",
    "source": "COMMODITY.LIVE",
    "function": "dielectric",
    "group": "FR4",
    "flexible": false,
    "additional": null,
    "link": "http://database.ul.com/cgi-bin/XYV/template/LISEXT/1FRAME/showpage.html?name=QMTS2.E189572&ccnshorttitle=Polymeric+Materials+-+Filament-wound+Tubing,+Industrial+Laminates,+Vulcanized+Fiber,+and+Materials+for+Use+in+Fabricating+Recognized+Printed+Wiring+Boards+-+Component&objid=1073838873&cfgid=1073741824&version=versionless&parent_id=1073838300&sequence=1",
    "remark": null,
    "ul_94": "v-0",
    "accept_equivalent": null,
    "manufacturer": {
        "name": "TUC",
        "verified": null,
        "description": null,
        "location": null
    },
    "material_attributes": [
        {
            "name": "ipc_slash_sheet",
            "material_attribute_values": [
                {
                    "value": "[\"127\", \"128\", \"130\"]",
                    "value_type": null
                }
            ]
        },
        {
            "name": "tg_min",
            "material_attribute_values": [
                {
                    "value": "200",
                    "value_type": null
                }
            ]
        },
        {
            "name": "td_min",
            "material_attribute_values": [
                {
                    "value": "370",
                    "value_type": null
                }
            ]
        },
        {
            "name": "resin",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "resin_content",
            "material_attribute_values": [
                {
                    "value": "50",
                    "value_type": null
                }
            ]
        },
        {
            "name": "woven_reinforcement",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "filler",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "reinforcement",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "thickness",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "dk",
            "material_attribute_values": [
                {
                    "value": "4.6",
                    "value_type": null
                }
            ]
        },
        {
            "name": "cti",
            "material_attribute_values": [
                {
                    "value": "3",
                    "value_type": null
                }
            ]
        },
        {
            "name": "frequency",
            "material_attribute_values": [
                {
                    "value": "1000",
                    "value_type": null
                }
            ]
        },
        {
            "name": "df",
            "material_attribute_values": [
                {
                    "value": "0.013",
                    "value_type": null
                }
            ]
        },
        {
            "name": "t260",
            "material_attribute_values": [
                {
                    "value": "60",
                    "value_type": null
                }
            ]
        },
        {
            "name": "t280",
            "material_attribute_values": [
                {
                    "value": "60",
                    "value_type": null
                }
            ]
        },
        {
            "name": "t300",
            "material_attribute_values": [
                {
                    "value": "-",
                    "value_type": null
                }
            ]
        },
        {
            "name": "mot",
            "material_attribute_values": [
                {
                    "value": "130",
                    "value_type": null
                }
            ]
        },
        {
            "name": "z_cte",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "z_cte_before_tg",
            "material_attribute_values": [
                {
                    "value": "35",
                    "value_type": null
                }
            ]
        },
        {
            "name": "z_cte_after_tg",
            "material_attribute_values": [
                {
                    "value": "180",
                    "value_type": null
                }
            ]
        },
        {
            "name": "dielectric_breakdown",
            "material_attribute_values": [
                {
                    "value": "50",
                    "value_type": null
                }
            ]
        },
        {
            "name": "water_absorption",
            "material_attribute_values": [
                {
                    "value": "0.13",
                    "value_type": null
                }
            ]
        },
        {
            "name": "thermal_conductivity",
            "material_attribute_values": [
                {
                    "value": "0.62",
                    "value_type": null
                }
            ]
        },
        {
            "name": "electric_strength",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        },
        {
            "name": "foil_roughness",
            "material_attribute_values": [
                {
                    "value": null,
                    "value_type": null
                }
            ]
        }
    ]
}
```

## About types and how to use them
Under each element and subelement, you'll find the type that is expected there. These are to be understood as this:
* **object** - the element will contain other elements
* **array** - a list/array of value or elements. In JSON the values are enclosed in brackets. E.g. `[1, 2, 3]` or `["white", "yellow", "blue"]`
* **number** - any number. In JSON this is given without hyphens, e.g. `1.2` or `1`. If a whole number is expected, then this will be stated with `number (integer)` as the type.
* **string** - any set of characters, e.g. `"white"`.
* **boolean** - either `true` or `false`

## Contributing to the project
We really appreciate all involvement. If you feel that there are additions (such as other sources) or changes needed to the material database, please start out by raising the issue in the [CircuitData Forum](https://www.circuitdata.org/). Then clone this repo and branch out before you make your changes. Please use a branch name that explains what you want to add. When you are done and have tested it, make a Pull Request in this GitHub project. It is the board of CircuitData that decided when code is to merged with the master and thus become part of the application.

## Database Elements
====================

### material [link](#material)
* circuitdata_version
* id
* name
* verified
* source
* function
* group
* flexible
* additional
* link
* remark
* ul_94
* accept_equivalent
* manufacturer
* material_attributes

### material_attributes [link](#material_attributes)
* name
* material_attribute_values

### material_attribute_values [link](#material_attribute_values)
* value
* value_type

### manufacturer [link](#manufacturer)
* id
* name
* verified
* description
* location
* ul
* ul_c

### material
The Material and all it's elements including the manufacrurer and the material attributes.

|  | Type | Default value | Visible element | Values allowed | Comment |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|
| **circuitdata_version** | string | 1.0 | Yes | 1.0 | Reflect the version of CircuitData |
| **id** | uuid |  | Only in list |  | Unique identifier used to extract one material |
| **name** | string |  | Yes |  | Name of material |
| **verified** | boolean | false | Yes | true, false | Indicates if the Material is officially verified|
| **function** |string |  | Yes | "conductive", "dielectric", "soldermask", "stiffener", "final_finish" | Function of the material |
| **group** | string |  | Yes | "FR1", "FR2", "FR3", "FR4", "FR5", "G-10", "G-11", "CEM-1", "CEM-2", "CEM-3", "CEM-4", "CEM-5", "ceramic", "polyimide", "aramid", "acrylic", "LCP", "PEN", "PET", "LPISM", "DFISM", "LDISM", "stainless_steel", "copper", "aluminum", "silver", "gold", "carbon", "silver_platinum", "silver_paladium", "gold_platinum", "platinum", "c_bare_copper", "isn", "iag", "enig", "enepig", "osp", "ht_osp", "g", "GS", "t_fused", "tlu_unfused", "dig", "gwb-1_ultrasonic", "gwb-2-thermosonic", "s_hasl", "b1_lfhasl" | The group of the material |
| **link** | string |  | Yes |  | Link to the datahseet of similar |
| **remark** | text |  | Yes |  | Any remarks about the material |
| **flexible** | boolean | false | Yes | true, false | If the material is flexible |
| **ul_94** | string |  | Yes | "v-0", "v-1", "hb" | The type of ul-94 |
| **additional** | array |  | Yes | "halogen_free", "ul", "rw_en45545_2_2013", "rw_nf_f_16_101", "rw_uni_cei_11170_3" and "rw_nfpa_130" | Additional information |
| **accept_equivalent** | boolean |  | Yes | true, false  | If it is acceptable with an equal material |
| **source** | string |  | Yes |  | The sorce the data is captured from |
| **manufacturer_id** | uuid |  | No |  | The relation to the manufacturer |
| **created_at** | datetime |  | No |  | When the material was created |
| **updated_at** | datetime |  | No |  | When the material was updated |


### matereial_attributes

|  | Type | Default value | Visible element | Values allowed | Comment |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|
| **id** | uuid |  | No |  | Unique identifier |
| **name** | string |  | Yes | [See list of Property Values](#property_values) | Name of the material attribute |
| **material_id** | uuid |  | No |  | The relation to the material |


### material_attribute_values

|  | Type | Default value | Visible element | Values allowed | Comment |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|
| **id** | uuid |  | No |  | Unique identifier |
| **value** | string |  | Yes | [See list of Property Values](#property_values) | Value of the material attribute |
| **value_type** | string |  | Yes | string, number, float, array, boolean | The type of format the value has |
| **material_attribute_id** | uuid |  | No |  | The relation to the material attribute |
| **created_at** | datetime |  | No |  | When the value was created |
| **updated_at** | datetime |  | No |  | When the value was updated |


### manufacturer
The manufacuterer of the material

|  | Type | Default value | Visible element | Values allowed | Comment |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|
| **id** | uuid |  | No |  | Unique identifier |
| **name** | string |  | Yes | [See list of Property Values](#property_values) | Value of the material attribute |
| **verified** | boolean | false | Yes | true, false | Indicates if the Manufacturer is officially verified|
| **description** | string |  | Yes |  | The description of the Manufacturer |
| **location** | string |  | yes |  | Where the Manufacturer is located |
| **ul** | string |  | yes |  | The E-number of the Manufacturer |
| **ul_c** | string |  | yes |  | The E-number of the Manufacturer (Canada) |
| **created_at** | datetime |  | No |  | When the value was created |
| **updated_at** | datetime |  | No |  | When the value was updated |


### property_values
The possible properties and values used as material attributes and values.

| Property | Possible Values | Value type | Comment |
|:---------------:|:-------:|:----------------:|:----------------:|
| ipc_slash_sheet |  | array of integers |  | 
| tg_min |  | integer | UoM Celsius | 
| td_min |  | integer | UoM Celsius | 
| resin | "epoxy", "bt", "cyanate_ester", "phenolic", "polyester", "polyimide", "ppe", "hydrocarbon", "ptfe", "thermoplastic" | string |  | 
| resin_content |  | number | UoM Percent | 
| flame_retardent | "phosphor", "red_phosphor", "bromine", "chlorine", "antimony_oxide", "rohs_compliant_bromine" | string | UoM Celsius | 
| woven_reinforcement |  | boolean |  | 
| filler | ["ceramic", "kaolin", "organic", "inorganic", "glass"] | array |  | 
| reinforcement | "e-glass", "s-glass", "ne-glass", "l-glass", "quartz", "aramid", "paper" | string |  | 
| thickness |  | number | UoM Micrometer | 
| dk |  | number |  | 
| cti |  | number |  | 
| frequency |  | number | UoM Gigahertz | 
| df |  | number | UoM Minutes | 
| t260 |  | number | UoM Minutes |  
| t280 |  | number | UoM Minutes | 
| t300 |  | number | UoM Minutes | 
| mot |  | number | UoM Celcius | 
| z_cte |  | number | UoM Percent | 
| z_cte_before_tg |  | number | UoM Percent | 
| z_cte_after_tg |  | number | UoM Percent | 
| dielectric_breakdown |  | number | UoM kV | 
| water_absorption |  | number | UoM Percent | 
| thermal_conductivity |  | number | UoM W/mK | 
| volume_resistivity |  | number | UoM megaOhm/centimeter | 
| electric_strength |  | number | UoM W/mK | 
| foil_roughness | S, L, V | string |  | 
| ipc_sm_840_class | "T", "H", TF, HF | string | For soldermask | 
| finish | matte, glossy, semi_glossy | string | For soldermask | 

