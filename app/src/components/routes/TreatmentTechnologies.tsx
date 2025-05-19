import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";
import { Table } from "@/components/Table";

export function TreatmentTechnologies() {
  return (
    <section
      className={clsx(
        "tw-prose tw-max-w-none tw-p-4",
        "print:tw-p-0",
        "[&_dd_p:first-of-type]:tw-mt-0 [&_dd_p]:tw-mb-0",
      )}
    >
      <SectionHeading>Treatment Technology Descriptions</SectionHeading>

      <dl>
        <dt id="TreatmentTech">Treatment Technology</dt>

        <dd>
          <p>
            An individual treatment unit designed to remove pollutants from a
            wastewater stream. In IWTT, EPA classified treatment technology
            units into codes, ordered in series within a{" "}
            <Link
              to="/glossary#TreatmentSystem"
              target="_blank"
              rel="noopener noreferrer"
            >
              treatment system
            </Link>{" "}
            for comparative purposes.
          </p>
        </dd>
      </dl>

      <p>
        The table below provides descriptions of the general treatment
        technology names along with corresponding codes.
      </p>

      <Table className={clsx("tw-not-prose")}>
        <caption className={clsx("tw-mb-2 tw-text-center")}>
          IWTT Treatment Technologies and Descriptions
        </caption>
        <thead>
          <tr>
            <th>Treatment Technology Name</th>
            <th>Treatment Technology Code</th>
            <th>Treatment Technology Synonyms</th>
            <th>Treatment Technology Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Adsorptive Media</td>
            <td>ADSM</td>
            <td>N/A</td>
            <td>
              New materials used to remove pollutants via surface adhesion. Do
              not use this code for packed-bed or any granular-filtration
              process. Expect these to have copyrighted names. This code
              excludes GAC.
            </td>
          </tr>
          <tr>
            <td>
              Advanced Oxidation Processes, Not Classified Elsewhere (NEC)
            </td>
            <td>AOP</td>
            <td>
              Supercritical Water Oxidation, Catalytic Oxidation, Photo
              Catalysis (UV + TiO2), Fenton’s Reagent
            </td>
            <td>
              Various mechanisms to oxidize organic materials not classified
              elsewhere.
            </td>
          </tr>
          <tr>
            <td>Aeration</td>
            <td>AIR</td>
            <td>Aeration Channel, Aerobic Polishing Cell</td>
            <td>
              Providing contact with air or pure oxygen to increase dissolved
              oxygen (DO) in wastewater.
            </td>
          </tr>
          <tr>
            <td>Aerobic Biological Treatment</td>
            <td>AD</td>
            <td>Aerated Biological Removal, Aerobic Digestion</td>
            <td>
              Biodegradable organic compounds in wastewater are consumed by
              microorganisms. This process is aerated.
            </td>
          </tr>
          <tr>
            <td>Aerobic Fixed Film Biological Treatment</td>
            <td>AFF</td>
            <td>
              Attached Growth, Fixed Bed Reactor, Rotating Biological Contactor,
              Trickling Filter, Fluidized Bed Reactor
            </td>
            <td>
              Microorganisms attach to inert media. This process is aerated.
            </td>
          </tr>
          <tr>
            <td>Aerobic Suspended Growth</td>
            <td>ASG</td>
            <td>Activated Sludge, Aerobic Lagoon</td>
            <td>
              Biodegradable organic compounds in wastewater are consumed by
              microorganisms. The microorganisms are suspended within the
              wastewater, creating a sludge that is separated from the water
              (during clarification–CLAR). This process is aerated.
            </td>
          </tr>
          <tr>
            <td>Alkaline Chlorination</td>
            <td>AC</td>
            <td>N/A</td>
            <td>
              Used to destroy cyanides. Most often the process is operated in
              two stages, with separate tanks for each stage. Destruction of
              dilute solutions of cyanide by chlorination can be accomplished by
              direct addition of sodium hypochlorite (NaOCl), or by addition of
              chlorine gas plus sodium hydroxide (NaOH) to the wastewater.
            </td>
          </tr>
          <tr>
            <td>Anaerobic Biological Treatment</td>
            <td>AND</td>
            <td>Non-Aerated, Facultative</td>
            <td>
              A biological treatment process that is non-aerated, hence, without
              oxygen.
            </td>
          </tr>
          <tr>
            <td>Anaerobic Fixed Film Biological Treatment</td>
            <td>ANFF</td>
            <td>
              Attached Growth, Fixed Bed Reactor, Rotating Biological Contactor,
              Trickling Filter, Fluidized Bed Reactor
            </td>
            <td>Microorganisms attach to inert media.</td>
          </tr>
          <tr>
            <td>Anaerobic Membrane Bioreactor</td>
            <td>AnMBR</td>
            <td>N/A</td>
            <td>
              Combination of suspended growth biological treatment under low or
              zero dissolved oxygen conditions and ultrafiltration.
            </td>
          </tr>
          <tr>
            <td>Anaerobic Suspended Growth</td>
            <td>ANSG</td>
            <td>Anaerobic Lagoon</td>
            <td>
              Biodegradable organic compounds in wastewater are consumed by
              microorganisms. The microorganisms are suspended within the
              wastewater, creating a sludge that is separated from the water.
            </td>
          </tr>
          <tr>
            <td>Bag and Cartridge Filtration</td>
            <td>BCF</td>
            <td>N/A</td>
            <td>
              Used to remove suspended solids, typically in systems with lower
              flow rates. Filter media are shaped as bags or cylindrical
              cartridges.
            </td>
          </tr>
          <tr>
            <td>Ballasted Clarification</td>
            <td>BCLAR</td>
            <td>
              BioMag, CoMag, Enhanced Settling, High Rate Settling, Actiflo
            </td>
            <td>
              Improves gravitational settling rates by addition of a weighing
              agent to the clarifier, typically magnetite or sand.
            </td>
          </tr>
          <tr>
            <td>Bioaugmentation</td>
            <td>AUG</td>
            <td>N/A</td>
            <td>
              Addition of specialized microbial strains in a bioreactor to
              enhance the ability of the microbial community to respond to
              operational conditions and/or degrade compounds.
            </td>
          </tr>
          <tr>
            <td>Biofilm Airlift Suspension Reactor</td>
            <td>BASR</td>
            <td>Airlift Bioreactor</td>
            <td>
              Pneumatic device with defined channels for fluid flow. Air pumped
              into the unit forces the fluid to flow through channels (internal
              or external loops). Usually will contain gas, solid, and liquid
              phases.
            </td>
          </tr>
          <tr>
            <td>Biological Activated Carbon Filters</td>
            <td>BAC</td>
            <td>
              Granular media that support microbial growth, submerged aerated
              filter
            </td>
            <td>
              GAC, sand, or other filter media with microbial growth that can
              remove residual pollutants via filtration, adsorption,
              biodegradation, and bioregeneration.
            </td>
          </tr>
          <tr>
            <td>Biological Nutrient Removal</td>
            <td>BNR</td>
            <td>Modified Ludzack-Ettinger (MLE) Process</td>
            <td>
              General term for technologies designed to remove nitrogen species
              from wastewater.
            </td>
          </tr>
          <tr>
            <td>Biological Treatment</td>
            <td>XBIO</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: AD, AFF, AND, ANFF, ANSG, ASG, AUG, AnMBR, BAC,
              BASR, BIO, BNR, EBPR, FDN, GSBR, IFAS, MBBR, MBR, WET
            </td>
          </tr>
          <tr>
            <td>Capacitive Deionization</td>
            <td>DEI</td>
            <td>Electro-sorption</td>
            <td>
              Removal of dissolved ions through an electrochemical mechanism.
            </td>
          </tr>
          <tr>
            <td>Centrifugal Separators</td>
            <td>CS</td>
            <td>(Liquid) Hydrocyclone</td>
            <td>
              Mechanical separation of liquids or particles of different
              densities. Used to separate oil from water and separate light from
              dense solids.
            </td>
          </tr>
          <tr>
            <td>Chemical Disinfection</td>
            <td>CD</td>
            <td>
              Hydroxyl Radical, Oxygen, Hydrogen Peroxide, Chlorine Species,
              Halogens
            </td>
            <td>
              Use of chemicals to disinfect (destroy pathogens in) wastewater.
              Use CO when referring to oxidation of pollutants.
            </td>
          </tr>
          <tr>
            <td>Chemical Nitrogen Removal</td>
            <td>CNR</td>
            <td>N/A</td>
            <td>
              Redox reaction to remove nitrogen from water or convert between
              different forms of nitrogen.
            </td>
          </tr>
          <tr>
            <td>Chemical Oxidation</td>
            <td>CO</td>
            <td>Hydrogen Peroxide, Permanganate, Chlorine, Bleach</td>
            <td>
              Addition of chemicals (in any phase) to oxidize organic compounds.
              This code excludes ozone.
            </td>
          </tr>
          <tr>
            <td>Chemical Phosphorous Removal</td>
            <td>CPR&nbsp;</td>
            <td>N/A</td>
            <td>
              Addition of metal-salts, most commonly alum, to precipitate
              phosphorus species out of solution.
            </td>
          </tr>
          <tr>
            <td>Chemical Precipitation</td>
            <td>ChemPre</td>
            <td>Coagulation and Flocculation</td>
            <td>
              Process to remove suspended solids from water. Chemical addition
              first neutralizes charged particles (coagulation) and promotes
              particle adhesion to form large, visible clumps (flocculation)
              that can then settle out of the wastewater. This term is also used
              for the addition of lime, alum, ferric sulfite, or other
              precipitants to remove soluble metals from solution by forming
              insoluble compounds.
            </td>
          </tr>
          <tr>
            <td>Chemical Treatment</td>
            <td>XCHM</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: AC, AKH, AOP, CD, CNR, CO, CPR, ChemPre, DCL,
              GAS, ION, LE, OZ, UV, WAO, ZVI
            </td>
          </tr>
          <tr>
            <td>Clarification</td>
            <td>CLAR</td>
            <td>Settling, Sedimentation</td>
            <td>
              Separation of suspended particles from water by gravitational
              settling.
            </td>
          </tr>
          <tr>
            <td>Cloth Filtration</td>
            <td>CF</td>
            <td>Cloth Media (Disc) Filter</td>
            <td>
              Water is passed through a cloth medium to remove solids. Cloth is
              often shaped into discs.
            </td>
          </tr>
          <tr>
            <td>Constructed Wetlands</td>
            <td>WET</td>
            <td>Reed Bed, Artificial Wetland, Peat Land</td>
            <td>
              Application of natural processes and use of vegetation to remove
              BOD, nutrients, and suspended solids. “Green” technology that can
              minimize energy used for water treatment.
            </td>
          </tr>
          <tr>
            <td>Controlled Hydrodynamic Cavitation</td>
            <td>CHC</td>
            <td>Mechanical Energy Device</td>
            <td>
              Device that uses mechanical energy to prevent biofouling, scale,
              and corrosion. The high temperatures and physical forces generated
              promote chemical reactions, oxidize organic compounds, and kill
              pathogens. Cavitation is the formation and implosion of cavities
              (bubbles) in a liquid.
            </td>
          </tr>
          <tr>
            <td>Crystallization</td>
            <td>CYS</td>
            <td>Fluidized Bed Crystallization</td>
            <td>
              Crystallization describes the formation of solid crystals
              precipitating from a solution. It can be applied post-evaporation
              (EVAP) to create a solid waste product or to recover a product in
              the wastewater. When used for product recovery, crystallization
              combines four treatment steps–coagulation, flocculation,
              sludge/water separation, and dewatering. High-purity, reusable
              water is also produced.
            </td>
          </tr>
          <tr>
            <td>Dechlorination</td>
            <td>DCL</td>
            <td>N/A</td>
            <td>
              The process of removing residual chlorine from disinfected
              wastewater prior to discharge into the environment. Sulfur dioxide
              is most commonly used. Not to be confused with degradation of
              chlorinated organics.
            </td>
          </tr>
          <tr>
            <td>Degasification</td>
            <td>DGS</td>
            <td>Membrane Degasification, Forced Draft Degasification</td>
            <td>
              Removal of dissolved gases from water by pressure reduction,
              membrane degasification, or an unspecified method. This includes
              heating to remove a gas. If heating is used to vaporize water, see
              EVAP.
            </td>
          </tr>
          <tr>
            <td>Denitrification Filters</td>
            <td>FDN</td>
            <td>N/A</td>
            <td>
              Granular-media filtration beds that support growth of denitrifying
              bacteria. These units reduce nitrate to nitrogen gas and remove
              suspended solids.
            </td>
          </tr>
          <tr>
            <td>Dissolved Air Flotation</td>
            <td>DAF</td>
            <td>N/A</td>
            <td>
              Air is dissolved under pressure and then released at atmospheric
              pressure in a tank. The released air creates bubbles which adhere
              to suspended solids, causing the solids to float to the surface
              where they can be removed by skimming. Removes suspended solids,
              oil, and grease
            </td>
          </tr>
          <tr>
            <td>Dissolved Gas Flotation</td>
            <td>DGF</td>
            <td>N/A</td>
            <td>
              Same process as DAF, but uses gases other than air (e.g., natural
              gas, nitrogen).
            </td>
          </tr>
          <tr>
            <td>Distillation</td>
            <td>DST</td>
            <td>N/A</td>
            <td>
              Contaminated water is heated to form steam, leaving inorganic
              compounds and large, non-volatile organic molecules behind. The
              steam is then condensed, forming purified water. Distillation
              requires input of energy and collection of the purified water.
            </td>
          </tr>
          <tr>
            <td>Electrocoagulation</td>
            <td>EC</td>
            <td>N/A</td>
            <td>
              Entails passing the wastewater across metal electrodes. EC is used
              to remove colloids, heavy metals, and emulsified oils. The direct
              current solubilizes metal ions and destabilizes charged particles,
              promoting coagulation and flocculation.
            </td>
          </tr>
          <tr>
            <td>Electrodialysis</td>
            <td>ED</td>
            <td>Electrodialysis Reversal (EDR)</td>
            <td>
              Involves moving ions in a potential ﬁeld across alternating
              polymeric anion- and cation-exchange membranes. A potential
              difference applied across the membranes traps ions and separates a
              brine waste stream from purified water. Electrodialysis works best
              for removing low molecular weight charged species.
            </td>
          </tr>
          <tr>
            <td>Enhanced Biological Phosphorus Removal</td>
            <td>EBPR</td>
            <td>Enhanced Biological Phosphorus Uptake</td>
            <td>
              Use of phosphate-accumulating organisms to store phosphate within
              the cell. Phosphate removed in waste sludge.
            </td>
          </tr>
          <tr>
            <td>Evaporation</td>
            <td>EVAP</td>
            <td>N/A</td>
            <td>
              Water is vaporized and sometimes condensed for reuse. The
              remaining product is concentrated brine containing the dissolved
              solids from the original wastewater. The process may be carried
              out naturally in solar (shallow) evaporation ponds or through the
              use of commercially available evaporation equipment. The brine may
              be further concentrated during the crystallization process (CYS).
            </td>
          </tr>
          <tr>
            <td>Flow Equalization</td>
            <td>EQ</td>
            <td>Buffer tank, Flow Control, Flow Balance</td>
            <td>
              A basin, lagoon, tank, or reactor that serves to control a
              variable flow of wastewater to achieve a near constant flow into
              the treatment system or between units.
            </td>
          </tr>
          <tr>
            <td>Forward Osmosis</td>
            <td>FO</td>
            <td>Engineered or Manipulated Osmosis</td>
            <td>
              Water transfer through a selectively permeable membrane driven by
              the osmotic pressure difference across the membrane. Water is
              drawn across a membrane to a solution with a higher concentration
              (relative to the wastewater). The resulting separated water must
              then be further treated to produce a high quality effluent.
            </td>
          </tr>
          <tr>
            <td>Gasification</td>
            <td>GAS</td>
            <td>Downdraft, Updraft or Fluidized Bed Gasifier</td>
            <td>
              Thermo-chemical process to convert carbon-containing biosolids
              into gas (carbon dioxide and methane) and energy. Resulting energy
              can be used for heating. Gases are used to generate fuels,
              electricity, and heat. GAS also reduces the volume of solids for
              disposal.
            </td>
          </tr>
          <tr>
            <td>Granular Activated Carbon Adsorption</td>
            <td>GAC</td>
            <td>N/A</td>
            <td>
              Uses the physical/chemical adsorption process to remove soluble
              contaminants from wastewater. GAC is a highly effective adsorbent
              due to its large surface area and high porosity. Used to remove
              organics and some metals and for taste and odor control.
            </td>
          </tr>
          <tr>
            <td>Granular Sludge Sequencing Batch Reactor</td>
            <td>GSBR</td>
            <td>N/A</td>
            <td>
              Aerobic biological treatment with enhanced sludge settling by
              formation of granular sludge, without the use of carrier
              materials. Granular sludge developed by selection of biomass with
              short settling times.
            </td>
          </tr>
          <tr>
            <td>Granular-Media Filtration</td>
            <td>FI</td>
            <td>Conventional, Multi-Media, or Sand Filtration</td>
            <td>
              Removal of suspended solids is accomplished by passing wastewater
              through a filter bed of granular media. Media may include sand,
              walnut shells, and steel slag.
            </td>
          </tr>
          <tr>
            <td>Hydrolysis, Alkaline or Acid</td>
            <td>AKH</td>
            <td>N/A</td>
            <td>
              Addition of an acid or base (e.g., sodium or potassium hydroxide)
              to enhance biodegradability of organic substances. Used as a
              pretreatment step before biological treatment and to reduce the
              toxicity of pesticides.
            </td>
          </tr>
          <tr>
            <td>Integrated Fixed Film Activated Sludge</td>
            <td>IFAS</td>
            <td>N/A</td>
            <td>
              Carrier media added to an activated sludge system to increase
              loadings without increasing the plant footprint. Often used for
              retrofits.
            </td>
          </tr>
          <tr>
            <td>Ion Exchange</td>
            <td>ION</td>
            <td>Softening, Deionization</td>
            <td>
              Ion exchange is a physical-chemical process in which ions are
              swapped between a solution phase and a solid resin phase.
              Different resins are used to target different charged particles.
              Commonly used for softening (removing dissolved calcium and
              magnesium) and nitrate removal.
            </td>
          </tr>
          <tr>
            <td>Liquid Extraction</td>
            <td>LE</td>
            <td>(Flotation) Liquid-Liquid Extraction, Solvent Extraction</td>
            <td>
              Separation of chemicals based on different solubilities in two
              solutes. Allows recovery of the chemical from wastewater.
            </td>
          </tr>
          <tr>
            <td>Mechanical Pre-Treatment</td>
            <td>MPT</td>
            <td>
              Screen, Bar, Rack, Grit Chamber, Comminuter, Grinder, Preliminary
              Treatment
            </td>
            <td>
              Physical removal of debris and coarse solids. This is the first
              step in wastewater treatment, which serves to protect downstream
              treatment equipment.
            </td>
          </tr>
          <tr>
            <td>Media Filtration</td>
            <td>XFIL</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: BCF, CF, FI
            </td>
          </tr>
          <tr>
            <td>Membrane Bioreactor</td>
            <td>MBR</td>
            <td>N/A</td>
            <td>
              Combination of aerobic suspended growth biological treatment and
              ultrafiltration. Ultrafiltration replaces the use of secondary
              clarifiers (solids separation) in conventional WWTPs. Can be used
              to reduce BOD, TSS, nitrogen, and phosphorus.
            </td>
          </tr>
          <tr>
            <td>Membrane Distillation</td>
            <td>MD</td>
            <td>N/A</td>
            <td>
              A separation process where a temperature difference across a
              hydrophobic membrane separates two aqueous solutions. Water vapor
              is driven through the membrane by vapor pressure, induced by the
              temperature difference, and condenses. See also DST.
            </td>
          </tr>
          <tr>
            <td>Membrane Filtration</td>
            <td>XMEM</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: FO, MD, MF, NANO, RO
            </td>
          </tr>
          <tr>
            <td>Micro- and Ultra-Membrane Filtration</td>
            <td>MF</td>
            <td>Microfiltration, Ultrafiltration</td>
            <td>
              Filtration methods that remove particles as small as 100 nm
              (microfiltration) and 10 nm (ultrafiltration). Many molecules are
              within this size range.
            </td>
          </tr>
          <tr>
            <td>Moving Bed Bioreactor</td>
            <td>MBBR</td>
            <td>N/A</td>
            <td>
              A hybrid suspended, growth-fixed film system. “Biocarrier” media
              are provided in the unit for the microorganisms to grow on.
              Increases the effective surface area for reaction while reducing
              the footprint of the system.
            </td>
          </tr>
          <tr>
            <td>Nanofiltration</td>
            <td>NANO</td>
            <td>N/A</td>
            <td>
              A membrane filtration method used to remove particles as small as
              1 nm from wastewater. This includes divalent and large monovalent
              ions (e.g., heavy metals). Used for desalination and softening.
            </td>
          </tr>
          <tr>
            <td>Oil/Water Separation</td>
            <td>OW</td>
            <td>API Separators</td>
            <td>
              Removal of gross quantities of oil and suspended solids by
              skimming and collecting oil from the surface of the wastewater.
            </td>
          </tr>
          <tr>
            <td>Other Filtration</td>
            <td>FILT</td>
            <td>N/A</td>
            <td>
              Filtration not elsewhere classified or unspecified, excluding any
              membrane filtration, bag & cartridge filtration (BCF), cloth
              filtration (CF), or granular media filtration (FI).
            </td>
          </tr>
          <tr>
            <td>Ozonation</td>
            <td>OZ</td>
            <td>Advanced Oxidation Process</td>
            <td>
              Ozone is a highly unstable gas used to either oxidize organic
              substances or disinfect wastewater. It must be produced onsite for
              immediate use in a contact chamber.
            </td>
          </tr>
          <tr>
            <td>Physical Treatment</td>
            <td>XPYS</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: ADSM, AIR, BCF, BCLAR, CF, CHC, CLAR, CS, CYS,
              DAF, DEI, DGF, DGS, DST, EC, ED, EQ, EVAP, FI, FO, GAC, MF, MPT,
              NANO, OW, PAC, RO, ST, US
            </td>
          </tr>
          <tr>
            <td>Powdered Activated Carbon</td>
            <td>PAC</td>
            <td>N/A</td>
            <td>
              Same removal mechanisms as GAC, but finer particles (&lt;= 1.0 mm
              diameter).
            </td>
          </tr>
          <tr>
            <td>Reverse Osmosis</td>
            <td>RO</td>
            <td>Desalination</td>
            <td>
              A membrane filtration method used to remove small ions (e.g., Na+)
              from water. Requires a high pressure hydraulic pressure gradient
              to counteract the osmotic pressure gradient that would otherwise
              favor movement of water into (instead of out of) the concentrated
              wastewater or saltwater.
            </td>
          </tr>
          <tr>
            <td>Sorption</td>
            <td>XSPT</td>
            <td>N/A</td>
            <td>
              Search criteria category including the following treatment
              technology codes: ADSM, GAC, PAC
            </td>
          </tr>
          <tr>
            <td>Stripping</td>
            <td>ST</td>
            <td>Air or Gas Stripping</td>
            <td>
              The removal of substances with equilibrium vapor pressures at
              ambient temperatures, such as ammonia and many volatile organic
              compounds (VOCs).
            </td>
          </tr>
          <tr>
            <td>Surface Impoundment</td>
            <td>SI</td>
            <td>N/A</td>
            <td>
              Natural or man-made topographic depression with a dammed location
              that is primarily made of earthen material and used to volatilize
              and/or settle materials.
            </td>
          </tr>
          <tr>
            <td>Unspecified Biological Treatment</td>
            <td>BIO</td>
            <td>N/A</td>
            <td>
              Biodegradable organic compounds in wastewater are consumed by
              microorganisms. This is a general term that should only be used
              for unspecified biological treatments.
            </td>
          </tr>
          <tr>
            <td>Ultrasound</td>
            <td>US</td>
            <td>Sonication</td>
            <td>
              High frequency bandwidth of sound applied to agitate particles in
              solution and disrupt cell membranes. Used in water storage
              facilities to suppress algal growth and biofilm formation.
            </td>
          </tr>
          <tr>
            <td>UV</td>
            <td>UV</td>
            <td>Ultraviolet Light or Radiation</td>
            <td>
              Ultraviolet radiation penetrates the wastewater to oxidize
              organics and/or disinfect. Used as a last, polishing step in
              wastewater treatment. May be used with chemical oxidants such as
              peroxide and ozone.
            </td>
          </tr>
          <tr>
            <td>Wet Air Oxidation</td>
            <td>WAO</td>
            <td>N/A</td>
            <td>
              The oxidation of soluble or suspended components in water using
              oxygen as the oxidizing agent. Air is used as the source of
              oxygen.
            </td>
          </tr>
          <tr>
            <td>Zero Valent Iron</td>
            <td>ZVI</td>
            <td>nZVI</td>
            <td>
              Granular or nanoscale ZVI is used to remove metals by adsorption
              and reductive precipitation mechanisms. Utilized through a
              separate reactor unit. Similar configuration to granular-media
              filtration.
            </td>
          </tr>
        </tbody>
      </Table>
    </section>
  );
}
