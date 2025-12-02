# MEDSWINE
NetLogo files for "Simulation of Infectious Diarrheal Disease in Philippine Backyard Swine Industry"

# OVERVIEW

## ABOUT

This code is part of the paper "Simulation of Infectious Diarrheal Disease in Philippine Backyard Swine Industry"

For inquiries, contact Dr. Jomar F. Rabajante: jfrabajante@up.edu.ph

## ABSTRACT & PURPOSE

Infectious diarrheal diseases, such as porcine epidemic diarrhea (PED), have caused significant piglet mortality in many countries, including the Philippines. These diseases remain a persistent threat to the swine industry, necessitating continuous monitoring due to their economic impact. Reports indicate that multiple fecal-oral transmission pathways contribute to the spread of diarrheal pathogens, complicating efforts to predict and control outbreaks. 

To address this, we developed a mathematical model incorporating various modes of disease transmission to analyze the dynamics of pathogen spread, with a particular focus on backyard farming. Backyard farms account for over 60% of the swine industry in the Philippines, making them a critical factor in disease management and control. An agent-based simulation was used to examine the spread of the diarrhea-causing pathogen within individual farms and across a network of backyard farms. We considered three farm types based on their operations: farrow-to-finish, farrow-to-wean, and grow-to-finish. 

Our goal is to predict the speed of pathogen spread and piglet mortality, with consideration for the amount of pathogen shed by infected pigs. Additionally, we aim to assess the impact of two key parameters (immunity level and recovery rate) on disease control. We aim to observe what farm type (e.g., farrow-to-wean and farrow-to-finish operations) experience high mortality rates, primarily due to the heightened susceptibility of piglets to the disease. 

Moreover, we aim to show that in all farm types considered in the study, farm owners can maintain productivity in their swine operations amid diarrhea epidemics, given effective interventions are implemented (e.g., prevention and feedback). These findings are crucial for predicting the productivity of backyard farms affected by an outbreak.

# DESIGN CONCEPTS

## STRUCTURE & ASSUMPTIONS

This simulation uses "turtles" to represent agents (in this case, pigs) and "patches" to simulate the environment, such as farmhouses. In our simulations, pigs and patches follow instructions coded into the program. We can control the behavior of pigs and the environment by adjusting agent variables, which reflect real farming system properties. Different setups were considered for each pig operation.

SIZE: For the pigs, we used the pig icon from the "Life of Pi(gs)" model. A visible distinction between pigs in the simulation is their size, which indicates their age group: piglets (28 days old or younger), adult pigs (older than 28 days), and sows. Pig size determines how many patches it occupies—piglets take up two patches, adult pigs have three patches, and sow occupy five patches. The The fecal output of adult pigs and sows covers nine patches, while piglet feces occupy one patch.  

COLOR: When a pig becomes infected, it turns red, while pink-colored pigs denote susceptibility. Sows turn magenta during gestation. Moreover, gray patches represent areas where pigs can move and stay, while brown patches indicate areas where pigs have defecated, signifying the presence of the IDD pathogen. 

The NetLogo world (the set of all the patches) is divided into stalls corresponding to those in a typical farmhouse. Pig movement is included in the model, but activities such as eating and drinking are not. We assume that pigs defecate randomly within their designated stalls and can move freely at any time. Their movement is also assumed to be random. The simulation runs in ticks, where each tick represents one day, and a full simulation covers 365 days (one year).

In all farming operations, the following assumptions are applied: 

(I) All pigs have the same probability of acquiring the pathogen and developing IDD. While we do not explicitly differentiate between pigs that show clinical signs and those that do not, only infected pigs are modeled as defecating. 

(II) The primary source of infection is the environment, specifically contaminated pig feces. However, a sow's infection status can influence the health of its litter. 

(III) We incorporate a feedback effect, meaning that piglets born to infected sows are assumed to have immunity. These immune piglets will not contract the disease or die from it until they reach 28 days old. In contrast, susceptible sows will produce susceptible litters since they lack antibodies to pass on through their milk. 

(IV) The infection state of pigs remains unchanged when they are transferred between locations. 

(V) To simplify the model, we do not consider the natural death rate of pigs. The only mortality accounted for is due to disease fatality. 

(VI) Gilts or replacement stock are not included in the model.

# DETAILS

## RUNNING THE SIMULATION 

The interface tab in NetLogo provides various tools, including buttons, sliders, monitors, and plots, to make the model more user-friendly for manipulation and visualization. These features allow users to modify parameter values easily and set them to the desired levels. Unless otherwise specified, the adult pig population includes sows and all pigs older than 28 days. Once the parameters are set, users can initialize the system by clicking the 'setup' button and start the simulation by clicking 'go'. These buttons trigger predefined procedures when activated. 

The 'put-sows' button adds one susceptible sow to the model while 'put-pigs' adds a specified number of susceptible adult pigs (28 days or older) to a selected region, based on the 'Additional-pigs' and 'in-region' inputs. These pigs are assumed to be naive to the pathogen. The 'put-pigs?' (switch) automatically places susceptible adult pigs into vacant stalls, with the number specified by 'Add-pigs-in-vacant-region'. Moreover, the 'auto-infect' switch enables automatic infection of a randomly chosen sow, while the 'infect' button allows users to manually trigger an infection. Likewise, the 'get-pregnant?' switch automatically selects a sow to become pregnant, while the 'get-pregnant' button allows users to manually choose one.

KEY SIMULATION PARAMETERS: All parameters are non-negative, and their values can be adjusted within the NetLogo interface. 

1. duration: decay of IDD pathogen (days) 
2. P: probability of infection of adjacent stall or house 
3. pathogen-shed-p: shedding rate of infected piglets 
4. pathogen-shed-a: shedding rate of infected adult pigs and sows 
5. lose-immunity-s: rate of immunity loss of recovered sows 
6. lose-immunity-a: rate of immunity loss of recovered adult pigs 
7. recovery: rate of recovery of infected pigs 
8. transmission-rate-a: rate of transmission of pathogen to susceptible adult pigs 
9. transmission-rate-p: rate of transmission of pathogen to susceptible piglets 
10. selling-rate-p: selling rate of piglets 
11. selling-rate-a: selling rate of adult pigs 
12. buying-rate: buying rate of susceptible piglets for grow-to-finish operation 
13. death-rate-a: death rate of infected adult pigs due to disease 

Another important factor considered in the simulation is pen cleaning, which involves removing pig feces by changing brown-colored patches (indicating feces) back to gray (clean areas). The 'Clean' chooser allows users to control the cleaning process with three options: 'off', where no cleaning occurs; 'Everyday', where cleaning is done daily; and 'too-much-poop', where cleaning is triggered when the number of brown patches (feces) exceeds the number of gray patches (clean areas). This feature enables the model to evaluate how different cleaning strategies affect the spread of disease within the pig pen.

## SPECIFIC TO FARROW-TO-FINISH

The farrow-to-finish operation combines both farrow-to-wean and grow-to-finish systems, involving sows, piglets, and growing pigs aged up to 150 days old. In this setup, different houses and stalls are designated for each pig population based on their growth stage or condition. In the NetLogo model, we assume that the house for sows and weaning piglets is located adjacent to the stalls for growing pigs, with the probability of pathogen transmission between houses being the same as that among stalls.

We assume that sows are assumed not to die from IDD, and natural death is not included in the model. Not all sows undergo gestation simultaneously; each follows a reproductive cycle where four months are allocated for gestation, and an additional one month after giving birth is required before the sow can conceive again. At the start of the simulation, all sows are naive to the pathogen, except for those that are initially infected.

Only pigs that develop IDD shed infected feces, allowing pathogen transmission from one pig to another. Transmission rates vary between piglets and adult pigs, including sows. Since IDD is more virulent in piglets aged 7 days or younger, their transmission rate is higher than that of adults and sows. The pathogen can persist in feces for an average of 15 days, and in the NetLogo model, this is represented by the persistent presence of brown-colored patches. Removing feces from the environment signifies the eradication of the pathogen. To differentiate feces from piglets and adult pigs, only one patch turns brown for piglets, while 9 patches turn brown for adult pigs and sows. Although pigs typically produce around 11 pounds of manure daily, the model visualizes only feces that contain the pathogen. In this simulation, pigs that come into contact with an infected brown patch have a 100% probability of contracting the pathogen, as feces directly represent the presence of the disease.

The pigs within the house can have varying ages, but they are grouped so that those in the same stall are of the same age. Growing pigs remain in the fattening house until they reach 150 days old, at which point they are ready for market or further processing.

NetLogo interface for simulating the farrow-to-finish pig production system in a backyard setting: This interface models a closed-cycle pig operation that includes sows, piglets, and growing pigs up to 150 days old. Distinct stalls represent various production stages—such as farrowing, weaning, and grow-to-finish—allowing visualization of movement, infection dynamics, and population changes over time. The control panel enables users to adjust key parameters (e.g., transmission rate, recovery rate, shedding probability), trigger sow pregnancies, and introduce additional pigs. Summary statistics track piglet and adult populations, infection states, and mortalities. Brown patches denote pathogen-contaminated feces, which persist in the environment for a configurable duration and represent the main route of infection in the model.

## SPECIFIC TO FARROW-TO-WEAN

For the dynamics of the farrow-to-wean operation in a backyard farm, we considered initial sows (mother pigs). Unlike commercial farms, there is only one house with no stalls or divisions, meaning all sows and their litters are in direct contact. This setup allows every pig to have an equal probability of exposure to the pathogen. The gestation period is four months, with a one-month interval before a sow can become pregnant again. However, not all sows undergo gestation at the same time. We assumed that the number of piglets per litter follows a Poisson distribution with a mean of 11. Piglets aged 1 to 7 days have a 100% mortality rate if they acquire IDD. Piglets cannot be sold until they reach 28 days old, at which point they can be transferred to the market or other pig farm owners. Additionally, piglets born to infected sows have temporary immunity and will not contract IDD for the first 28 days, as they receive protection from their mother's milk. However, once they stop receiving maternal milk, they become susceptible to infection.

NetLogo interface for simulating the farrow-to-wean pig production system in a backyard setting: This model represents a simplified backyard system with five initial sows housed together without individual stalls, allowing unrestricted interaction between sows and piglets. The interface displays controls for parameter adjustments (e.g., transmission rate, immunity duration, virus shedding) and tracks population changes over time. Infection dynamics are visualized through graphs showing the number of susceptible, infected, and dead piglets and adults.

## SPECIFIC TO GROW-TO-FINISH

The grow-to-finish operation in backyard farms manages pigs from the weaning at 28 days to 150 days of age. In this setup, pigs of the same age are housed together in five separate stalls. However, infection can spread between stalls, with a high probability (80%) that pigs in adjacent stalls will become infected if one stall is affected. The pathogen can spread beyond individual stalls due to the farm design, as the walls of the stall are made of cement blocks with holes, which do not effectively block pathogen transmission. Additionally, farm caretakers can act as vectors, inadvertently spreading the pathogen between stalls as they check on or feed the pigs using shared farming equipment. Although piglets born to infected sows have temporary immunity, this immunity lasts 28 days. Beyond this period, pigs remain susceptible and can still contract and die from IDD, though at a lower mortality rate (1%). Once pigs reach 150 days old, they are considered finishers and are ready to be sold to market.

NetLogo interface for simulating the grow-to-finish pig production system in a backyard setting: This model represents the grow-to-finish stage, where pigs aged 28 to 150 days are grouped by age and housed in five separate stalls. The interface includes adjustable parameters for infection dynamics, immunity loss, buying and selling rates, and user-triggered infection events. Although pigs are separated by stall, pathogen transmission can occur across divisions due to porous stall walls made of cement blocks with holes, as well as indirect transmission via shared farming equipment handled by caretakers. The graph tracks the progression of infection, recovery, and mortality within the adult pig population.

## SIMPLE NETWORK OF DIFFERENT FARMS (spread.nlogo)

In analyzing the spread of the IDD pathogen across the three pig operations, we examined how long it took for the infection to propagate when introduced to only one operation. For instance, if the farrow-to-wean operation served as the starting point, the infection spread to the grow-to-finish and farrow-to-finish operations. We assumed that the 'put-pigs?' switch in the grow-to-finish operation was turned on, automatically filling vacant stalls with susceptible adult pigs. Meanwhile, the 'auto-infect' switch is turned off for both grow-to-finish and farrow-to-finish operations. To simulate this interconnected system, we used LevelSpace, an extension of Netlogo, allowing us to link and observe the interactions between the three models. The speed of pathogen spread was assessed based on the amount of pathogen present (represented by the volume of feces), which correlates with the frequency of infected pigs. Infection was transmitted to another operation once at least 50% of pigs in the initial operation were infected.
