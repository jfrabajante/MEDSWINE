extensions [ls]

globals [
  fw-model
  gf-model
  ff-model
  transmit-pedv
  transmit-pedv-2
]

breed [ piglets piglet ]

turtles-own [
  infected ]

to setup
  ls:reset
  ca
  ls:create-interactive-models 1 "1_farrow-wean.nlogo"
  set fw-model last ls:models

  ls:create-interactive-models 1 "2_grower-to-finish.nlogo"
  set gf-model last ls:models

  ls:create-interactive-models 1 "3_farrow-to-finish.nlogo"
  set ff-model last ls:models
  ls:ask ls:models [ setup ]
  reset-ticks
end

to go
  ls:ask ls:models [ go ] ; calls go in all models in LevelSpace
  if ( [ count turtles with [ infected ] ] ls:of fw-model > [ count turtles with [ not infected ] ] ls:of fw-model )
    [ set transmit-pedv true ]
  if ( transmit-pedv = true ) [
    ls:ask gf-model [ ask turtles [ infect 1 ] ]
  show "1"
    show ticks ]
  if ( [ count turtles with [ infected ] ] ls:of gf-model > [ count turtles with [ not infected ] ] ls:of gf-model )
  [ set transmit-pedv-2 true ]
  if ( transmit-pedv-2 = true ) [
    ls:ask ff-model [ set farm-infected true ]
  show "2"
    show ticks ]
  tick
  if ( ticks = 365 ) [ stop ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
18
36
81
69
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
94
38
157
71
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
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

## SIMPLE NETWORK OF DIFFERENT FARMS 

In analyzing the spread of the IDD pathogen across the three pig operations, we examined how long it took for the infection to propagate when introduced to only one operation. For instance, if the farrow-to-wean operation served as the starting point, the infection spread to the grow-to-finish and farrow-to-finish operations. We assumed that the 'put-pigs?' switch in the grow-to-finish operation was turned on, automatically filling vacant stalls with susceptible adult pigs. Meanwhile, the 'auto-infect' switch is turned off for both grow-to-finish and farrow-to-finish operations. To simulate this interconnected system, we used LevelSpace, an extension of Netlogo, allowing us to link and observe the interactions between the three models. The speed of pathogen spread was assessed based on the amount of pathogen present (represented by the volume of feces), which correlates with the frequency of infected pigs. Infection was transmitted to another operation once at least 50% of pigs in the initial operation were infected.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="30" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="365"/>
    <metric>[ count turtles with [ infected ] ] ls:of fw-model + [ count turtles with [ infected ] ] ls:of gf-model + [ count turtles with [ infected ] ] ls:of ff-model</metric>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
