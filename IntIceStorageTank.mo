

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

equation
  if noEvent(m1_flow>0.001) then
   R1=r/ri*(1/hi1+F+C)+r/kl*log(ro/ri)+r/k*log(r/ro);
  q1=2*pi*r*L*dT1/R1*N;
  else
     R1= Modelica.Constants.inf;
     q1=0;
  end if;

  der(r)=(q1-q2)/(2*pi*ro*L*N*rho_ice*ql*(r/ro));
  q2=m2_flow*cp2*(Tin2-Tm);
  Q=rho_ice*pi*(r^2-ro^2)*L*N*ql/3600/1000;

  if r>ro then
    Ice_remind=1;
  else
    Ice_remind=0;
  end if;

  connect(realExpression.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-69,-36},{-58,-36}}, color={0,0,127}));

  connect(prescribedHeatFlow.port, vol2.heatPort) annotation (Line(points={{-38,-36},{22,-36},{22,-60},{12,-60}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, vol1.heatPort) annotation (Line(points={{-34,44},{-24,44},{-24,60},{-10,60}}, color={191,0,0}));
  connect(prescribedHeatFlow1.Q_flow, realExpression1.y) annotation (Line(points={{-54,44},{-65,44}}, color={0,0,127}));
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
