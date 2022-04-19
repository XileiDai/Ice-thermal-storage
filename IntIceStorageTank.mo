

 //Thermal propertiy parameters
  parameter Modelica.SIunits.ThermalConductivity kl=15 "Thermal conductivity of tube";
  Modelica.SIunits.Temperature Tm=273.15 "Freezing temperature of water";
  Modelica.SIunits.ThermalConductivity k=2.22 "Thermal conductivity of ice";
  Modelica.SIunits.Density rho_ice=920 "Density of water";
  Modelica.SIunits.SpecificEnergy ql=334000 "specific energy for ice freezing";
  Real Q;

  //Thermal properties of the Medium1

  Medium1.ThermodynamicState sta_a11=Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow))  "Medium properties in port_a1";
  Modelica.SIunits.Temperature Tin1=Medium1.temperature(sta_a11)  "Inlet chilled liquid temperature";
  Modelica.SIunits.Temperature Tout1=vol1.T "Temperature of the fluid in tubes";
  Modelica.SIunits.Radius r(start=ro,fixed=true) "The height of ice";
  Modelica.SIunits.ThermalInsulance R1 "Thermal resistance";
  Modelica.SIunits.HeatFlowRate q1;
  Modelica.SIunits.Temperature Ttz1=(Tin1+Tout1)/2 "Temperature of the fluid in tubes";
  Modelica.SIunits.TemperatureDifference dT1= if noEvent(Tm-Ttz1>0) then Tm-Ttz1 else 0 "Temperature Difference";
  Modelica.SIunits.Density d1=Medium1.density(sta_a11)
                                                      "Density of fluid mixture";
  Modelica.SIunits.SpecificHeatCapacity cp1= Medium1.specificHeatCapacityCp(sta_a11)
                                                                                    "Specific heat capacity of fluid mixture";
  Modelica.SIunits.ThermalConductivity lambda1=Medium1.thermalConductivity(sta_a11) "Density of fluid mixture";
  Modelica.SIunits.DynamicViscosity mu1=Medium1.dynamicViscosity(sta_a11) "Dynamic viscosity of fluid mixture";
  Real Pr1 = cp1*mu1/lambda1 "Pr number";
  Modelica.SIunits.Velocity v1= if noEvent(m1_flow>0) then m1_flow/d1/pi/ri^2 else 0  "Velocity of the fluid in tubes";
  Real Re1= if noEvent(m1_flow>0) then d1*v1*2*ri/mu1 else 0 "Re number";
  Real Nu1= 0.023*Re1^0.8*Pr1^0.4;
  Modelica.SIunits.CoefficientOfHeatTransfer hi1= if noEvent(m1_flow>0) then Nu1/2/ri*lambda1 else 1 " Tube inner convection heat transfor coefficient";
  Modelica.SIunits.ThermalInsulance F=0.000199 "Dirt coefficient";
  Modelica.SIunits.ThermalInsulance C= 0.001497 "Contect factor";

  //Modelica.SIunits.Temperature Tsur "Temperature of the ice surface";
  Modelica.SIunits.Area A=2*pi*r*L*N "The variation of the ice surface";
  Modelica.SIunits.HeatFlowRate q2;
  Medium2.ThermodynamicState sta_a22= Medium2.setState_phX(port_a2.p, noEvent(actualStream(port_a2.h_outflow)), noEvent(actualStream(port_a2.Xi_outflow))) "Medium properties in port_a2";
  Modelica.SIunits.Temperature Tin2=Medium2.temperature(sta_a22) "Inlet chilled liquid temperature";
  Modelica.SIunits.Temperature Tout2=vol2.T;
  Modelica.SIunits.Temperature Ttz2=0.5*(Tout2+Tin2) "Temperature of the fluid in tubes";
  Modelica.SIunits.Density d2=Medium2.density(sta_a22)  "Density of fluid mixture";
  Modelica.SIunits.SpecificHeatCapacity cp2= Medium2.specificHeatCapacityCp(sta_a22) "Specific heat capacity of fluid mixture";
  Modelica.SIunits.ThermalConductivity lambda2=Medium2.thermalConductivity(sta_a22) "Density of fluid mixture";
  Modelica.SIunits.DynamicViscosity mu2=Medium2.dynamicViscosity(sta_a22) "Dynamic viscosity of fluid mixture";
  Real Pr2 = cp2*mu2/lambda2 "Pr number";
  Modelica.SIunits.Velocity v2= if noEvent(m2_flow>0) then m2_flow/d2/A_cross else 0 "Velocity of the fluid in tubes";
  Real Re2=d2*v2*2*r/mu2 "Re number";
  Real Nu2= 0.683*Re2^0.466*Pr2^0.333;
  Modelica.SIunits.CoefficientOfHeatTransfer hw= Nu2/2/r*lambda2 " Tube inner convection heat transfor coefficient";

  Modelica.Blocks.Interfaces.RealOutput Q_CumlCharge=Q
     annotation (Placement(transformation(extent={{100,4},{120,24}}),
        iconTransformation(extent={{100,4},{120,24}})));
  Modelica.Blocks.Interfaces.RealOutput q_disChar=q2
    annotation (Placement(transformation(extent={{100,-18},{120,2}})));
  Modelica.Blocks.Interfaces.RealOutput Ice_remind
    "0 for ice has been completely melted; "
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput q_Charge=q1
    annotation (Placement(transformation(extent={{-100,76},{-120,96}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-46,18},{-6,-22}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,6},{-18,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,20},{46,-20}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{16,8},{34,-10}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,-18},{-30,-58}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-30},{-42,-48}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-20},{20,-60}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),

        Ellipse(
          extent={{-70,60},{-30,20}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,48},{-42,30}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,60},{18,20}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,48},{6,30}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,60},{68,20}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,48},{56,30}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial; font-size: 10pt;\">This model is an ice-on-coil ice tank for TES. During the ice-charging process, glycol flows in the coil, and ice is gradually formed on the outside wall of the coil. As the ice is generated on the coil and the ice thickness increases, the thermal resistance between the glycol in the coil and water in the tank can be calculated:</span></p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-J3tnLZGU.png\" alt=\"R=r/r_in*(1/alpha_in+R_F+R_C)+r/lambda_tube*ln(r_o/r_in)+r/lambda_ice*ln(r/r_o)+1/alpha_o\"/></p>
<p><br><br>where <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-WZDgVa31.png\" alt=\"r_in\"/> ,<img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-jqBpkleo.png\" alt=\"r_o\"/> and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-fxprMk8W.png\" alt=\"r_ice\"/> are the inner radius of the tube, the outer radius of the tube, and ice layer radius, respectively; F is the fouling factor for the inside of the pipe wall; &nbsp;C is the contact resistance between the tube and ice; <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-QVzjvDbq.png\" alt=\"lambda_tube\"/><a name=\"_x0000_i1030\">&nbsp;</a>and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-yXTFeiqj.png\" alt=\"lambda_icer\"/><a name=\"_x0000_i1031\">&nbsp;</a>are the thermal conductivity of the tube wall and ice layer, respectively. <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-sqwJOaMR.png\" alt=\"alpha_o\"/><a name=\"_x0000_i1032\">&nbsp;</a>is the external heat-transfer coefficient between the ice surface and the water in the tank, which was ignored in this study, and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-axX3wsTK.png\" alt=\"alpha_ice\"/> is the internal convective heat-transfer coefficient. By assuming the heat-transfer process in the coil as the ideal tube heat-transfer process, the heat-transfer coefficent and the heat transfer between the glycol and the ice surface, referred to as the ice-charging rate, can be described as: </p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-alhFjaSd.png\" alt=\"alpha_in=Nu*lambda_glycol/(2*r_in)\"/></p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-XSytMku7.png\" alt=\"Nu=0.023*Re^0.8*Pr^0.4\"/> </p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-gFDqIxGv.png\" alt=\"Q_charge=A*Delta_T/R\"/></p>
<p>where <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-E4mdejmQ.png\" alt=\"A\"/><a name=\"_x0000_i1025\"><a name=\"_x0000_t75\">&nbsp;</a>is the surface area of the ice layer, and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-kOONfG8F.png\" alt=\"Delta_T\"/>&nbsp;is the temperature difference between the glycol and the ice surface.</a></p>
<p>According to the heat and mass conservation equation, the cooling provided by the glycol in the coil transforms to the water required for freezing on the coil:</p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-yYNGkoSN.png\" alt=\"Q_charge=gamma_i*der(m_ice)\"/></p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-apIFqHnG.png\" alt=\"m_ice=pi*(r_ice^2-r_in^2)*rho*L*N\"/></p>
<p>where <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-aFL933m9.png\" alt=\"Q_charge\"/><a name=\"_x0000_i1025\"><a name=\"_x0000_t75\">&nbsp;</a>is the heat-transfer rate from the glycol to the ice surface; <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-aBfFI6ST.png\" alt=\"gamma_ice\"/>&nbsp;is the latent heat of ice fusion; &nbsp;<img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-Io7V13vZ.png\" alt=\"m_ice\"/>is the mass of the ice formed on the tube. &nbsp;<img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-FEqG4TQh.png\" alt=\"rho_ice\"/> is the density of ice, <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-gYlOXjaH.png\" alt=\"L\"/> is the length of the tube, and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-LQ2vGHBq.png\" alt=\"N\"/>is the number of tubes in parallel. Therefore, the cooling energy stored in the ice tank can be calculated as follows: </a></p>
<p align=\"center\"><br><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-OY5XKyv5.png\" alt=\"Q_stored=pi*(r_ice^2-r_in^2)*rho_ice*L*N*gamma_ice\"/> </p>
<p><br>Similar to the charging process, during the discharging process, the cooling energy taken by the water can be calculated:</p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-PM7lL7NP.png\" alt=\"Q_discharge = c_p*m_w*(T_inlet-T_outlet)\"/></p>
<p>where <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-hwSQiyhR.png\" alt=\"c_p\"/> is the speci c heat capacity of water; mw is the water mass flow rate of the tank; <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-Xo78THVQ.png\" alt=\"T_inlet\"/> and <img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-8kOLZf6g.png\" alt=\"T_outlet\"/> are inlet and outlet water temperatures of the tank, respectively.</p>
<p><br>According to the heat and mass balance, the cooling provided by ice melting is equal to the cooling energy taken by the water on the secondary side of the heat exchanger:</p>
<p align=\"center\"><img src=\"modelica://IntIceStorageTank/Resources/Images/equations/equation-bATPqmSt.png\" alt=\"-gamma_icer*der(m_ice)=Q_discharge\"/></p>
<p><br><br><br><br>During the discharging process, the mass of ice and the cooling energy stored can be calculated the same as the charging process.</p>
<p><br><br><br><br><b><span style=\"font-family: Arial; font-size: 10pt;\">Reference</span></b>:</p>
<p>Jia L.Z., Liu J.J., Adrian C.,and Dai X.L.<sup>*</sup>. Deep learning and physics-based modeling for the optimization of ice-based thermal energy systems in cooling plants, <span style=\"color: #ff0000;\">Applied Energy xxxx </span>(Modelica model ) </p>
<p>Alex H.W. Lee, Jerold W. Jones, Modeling of an ice-on-coil thermal energy storage system,Energy Conversion and Management, Volume 37, Issue 10,1996, Pages 1493-1507. https://doi.org/10.1016/0196-8904(95)00224-3 (Mathmetic model).</p>
<p><b><span style=\"font-family: Arial; font-size: 10pt;\">Note</span></b>: This model was built based on the Library of Buildings 7.0.0.and Modelica 3.2.2.</p>
</html>", revisions="<html>

<p>This model is built first by Lizhi Jia and Xilei Dai in May 9, 2021.</p>

</html>"),
    uses(Buildings(version="7.0.0"), Modelica(version="3.2.2")));
end IntIceStorageTank;
