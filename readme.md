# General information
This is a modelica module for modelling ice-on-coil thermal storage system.

# Technical details

During the ice-charging process, glycol flows in the coil, and ice is gradually formed on the outside wall of the coil. As the ice is generated on the coil and the ice thickness increases, the thermal resistance between the glycol in the coil and water in the tank can be calculated:

$$R = \frac{r}{r_{in}}\left(\frac{1}{\alpha_{in}} + R_F + R_C\right) + \frac{r}{\lambda_{tube}}ln\left(\frac{r_o}{r_{in}}\right) 
+\frac{r}{\lambda_{ice}}ln\left(\frac{r}{{r_o}}\right)+\frac{1}{\alpha_{o}}$$

where $r_{in}$, $r_o$ and $r_{ice}$ are the inner radius of the tube, the outer radius of the tube, and ice layer radius, respectively; $R_F$ is the fouling factor for the inside of the pipe wall;  $R_C$ is the contact resistance between the tube and ice; $\lambda_{tube}$ and $\lambda_{ice}$ are the thermal conductivity of the tube wall and ice layer, respectively. $\alpha_o$ is the external heat-transfer coefficient between the ice surface and the water in the tank, which was ignored in this study, and $\alpha_ice$ is the internal convective heat-transfer coefficient. By assuming the heat-transfer process in the coil as the ideal tube heat-transfer process, the heat-transfer coefficent and the heat transfer between the glycol and the ice surface, referred to as the ice-charging rate, can be described as:

$$\alpha_{in} = \frac{Nu \lambda_{glycol}}{2{r_{in}}}$$
$$Nu=0.023 Re^{0.8} Pr^{0.4}$$
$$Q_{charge}=A\triangle T/R$$

where $A$ is the surface area of the ice layer, and $\Delta_T$ is the temperature difference between the glycol and the ice surface.

According to the heat and mass conservation equation, the cooling provided by the glycol in the coil transforms to the water required for freezing on the coil:
$$Q_{charge} = \gamma_{ice}\frac{\partial M_{ice}}{\partial t}$$
$$M_{ice}=\pi(r^2 - r_o^2)\rho L N$$

where $Q_{charge}$ is the heat-transfer rate from the glycol to the ice surface; gamma_ice is the latent heat of ice fusion;  m_iceis the mass of the ice formed on the tube.  rho_ice is the density of ice, L is the length of the tube, and Nis the number of tubes in parallel. Therefore, the cooling energy stored in the ice tank can be calculated as follows:

$$ Q_{stored} = \pi(r^2 - r_o^2)\rho L N \gamma_{ice}$$

Similar to the charging process, during the discharging process, the cooling energy taken by the water can be calculated:

$$Q_{discharge}= c_p m_w (T_{inlet}-T_{outlet})$$

where $c_p$ is the specific heat capacity of water; $m_w$ is the water mass flow rate of the tank; $T_{inlet}$ and $T_{outlet}$ are inlet and outlet water temperatures of the tank, respectively.

According to the heat and mass balance, the cooling provided by ice melting is equal to the cooling energy taken by the water on the secondary side of the heat exchanger:
$$-\gamma_{ice}\frac{\partial M_{ice}}{\partial t}=Q_{discharge}$$

During the discharging process, the mass of ice and the cooling energy stored can be calculated the same as the charging process.

# Parameter
|Type|Name|Default|Description|
|:---|:---:|:---:|:---|
Integer|$N$|$48$|Number of tubes in pararll
Length|$L$|$150$|The length of the tube $[m]$
Radius|$r_i$|$11e^{-3}$|The inner tube inner diameter $[m]$
Radius|$r_o$|$14.25e^{-3}$|The inner tube outer diameter $[m]$
Volume|$V_t$|$6*2.8*2.8$|The volume of the tank $[m^3]$
Area|$A_{cross}$|$2.8*2.8$|The Area of the tank that water flow through $[m^2]$
ThermalConductivity|$k_l$|$15$|Thermal conductivity of tube $[W/(m.K)]$
Temperature|$T_m$|$273.15$|Freezing temperature of water $[K]$
ThermalConductivity|k|$2.22$|Thermal conductivity of ice $[W/(m.K)]$
Density|$\rho_{ice}$|$920$|Density of water $[kg/m^3]$
SpecificEnergy|$q_l$|$334000$|specific energy for ice freezing $[J/kg]$

# Connectors
|Type|Name|Description|
|:---|:---|:---|
Output RealOutput|$Q_{CumlCharge}$
Output RealOutput|$q_{disChar}$
Output RealOutput|$Ice_{remind}$ | 0 for ice has been completely melted
Output RealOutput|$q_{Charge}$ 
# Reference
[1] *Jia, Lizhi, Junjie Liu, Adrian Chong, and Xilei Dai. "Deep learning and physics-based modeling for the optimization of ice-based thermal energy systems in cooling plants." Applied Energy 322 (2022): 119443.*

[2] *Lee, Alex HW, and Jerold W. Jones. "Modeling of an ice-on-coil thermal energy storage system." Energy conversion and management 37, no. 10 (1996): 1493-1507.*

[3] *Wetter, Michael, Wangda Zuo, Thierry S. Nouidui, and Xiufeng Pang. "Modelica buildings library." Journal of Building Performance Simulation 7, no. 4 (2014): 253-270.*

# Related libraries
Uses: Buildings (version="7.0.0"), Modelica (version="4.0.0")

# Citation
To cite this module, use

* *[Jia, Lizhi, Junjie Liu, Adrian Chong, and Xilei Dai. "Deep learning and physics-based modeling for the optimization of ice-based thermal energy systems in cooling plants." Applied Energy 322 (2022): 119443.](https://www.sciencedirect.com/science/article/abs/pii/S0306261922007711)*

```
@article{jia2022deep,
  title={Deep learning and physics-based modeling for the optimization of ice-based thermal energy systems in cooling plants},
  author={Jia, Lizhi and Liu, Junjie and Chong, Adrian and Dai, Xilei},
  journal={Applied Energy},
  volume={322},
  pages={119443},
  year={2022},
  publisher={Elsevier}
}
```