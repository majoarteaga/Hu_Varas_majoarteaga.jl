"""
    Hu and Varas (WP, 2021) A Theory of Zombie Lending: REPLICATION
    
    This code replicates Figure 2 (Panel A and Panel B) of Hu and Varas (2021). 
    The left panel shows the joint valuations of the entrepreneur and the bank,
    the right one only shows those of the bank. In this example, tb = 1.2921 and tg = 2.1006.
    
    In the figure, the red, blue, and green lines represent the value functions of the
    informed-good, the uninformed, and the informed-bad types, respectively. 
    
    Hu_Varas_majoarteaga.plot1 : Panel A of Figure 2
    Hu_Varas_majoarteaga.plot2 : Panel B of Figure 2
"""


module Hu_Varas_majoarteaga

    import Pkg
    
    # Pkg.add("LinearAlgebra")
    # Pkg.add("Statistics")
    # Pkg.add("ForwardDiff")
    # Pkg.add("Zygote")
    # Pkg.add("Optim")
    # Pkg.add("JuMP")
    # Pkg.add("Ipopt")
    # Pkg.add("BlackBoxOptim")
    # Pkg.add("Roots")
    # Pkg.add("SymPy")
    # Pkg.add("LeastSquaresOptim")
    # Pkg.add("DifferentialEquations")
    # Pkg.add("Pkg")
    # Pkg.add("BoundaryValueDiffEq")
    # Pkg.add("OrdinaryDiffEq")
    # Pkg.add("Plots")
    # Pkg.add("PlutoUI")

    using LinearAlgebra
	using Statistics
	using ForwardDiff
	using Zygote
	using Optim
	using JuMP
	using Ipopt
	using BlackBoxOptim
	using Roots
	using SymPy
	using LeastSquaresOptim
	using Optim: converged, maximum, maximizer, minimizer, iterations
	using Pkg
	using BoundaryValueDiffEq
	using OrdinaryDiffEq
	using Plots
	using PlutoUI
	using DifferentialEquations



# Setting up the parameters used in the paper (Figure 2)

	# Parameters
	r, m, F, delta, phi, theta, lambda, q0, c, dt, eta, psi = [0.1, 0, 1, 0.02, 1.5, 0.1, 2, 0.2, 0.2, 1e-4, 1, 0.06]
	R = 2*F;
	L = 1.25*(c+phi*theta*R)/(r+phi+eta);


	Dg = (c+phi*F)/(delta+phi);
	Db = (c+phi*theta*F)/(delta+phi+eta);
	PV_deltab = (c+phi*theta*R)/(delta+phi+eta);
	PV_rb = (c+phi*theta*R)/(r+phi+eta);
	PV_rg = (c+phi*R)/(r+phi);

	x     = symbols("x")
	eq1   = eta*x^2 - (eta-(r+phi))*x + (r+phi)*(Db/(Dg-Db)-(delta+phi)/(r+phi)*Dg/(Dg-Db))
	xx   = fzeros(eq1,-5,5)
	if (xx[1]<1 && xx[1]>0)
		q_bar = xx[1]
	else
		q_bar = xx[2]
	end

	D_bar = q_bar * Dg + (1-q_bar) * Db;
	Vg_bar = D_bar  + phi*(R-F)/(r+phi);
	Vb_bar = D_bar  + phi*theta*(R-F)/(r+phi+eta);

	# Solve for tb, tg, zombie_length, and mu_t
	Db_r = (c+phi*theta*F)/(r+phi+eta);
	zombie_length = 1/(r+phi+eta) * log((F - Db_r)/(L - Db_r));
	tb = -1/(lambda+eta)*( log(1/(1-q0)*(q0/q_bar-q0)) + eta*zombie_length );
	tg = tb+ zombie_length;
	mu_tb = q0/(1-q0)*exp(eta*tb) / (1+q0/(1-q0)*exp(eta*tb));
	mu_tg = q0/(1-q0)*exp(eta*tg) / (1+q0/(1-q0)*exp(eta*tg));

	Vu_bar  = mu_tg * Vg_bar + (1-mu_tg) * Vb_bar;
	V_tg = zeros(3,1);
	V_tg[1] = Vu_bar;
	V_tg[2] = Vg_bar;
	V_tg[3] = Vb_bar;


  function f!(du,u,p,t)
  	q0, r, phi, lambda, eta, c, phi, theta, R = p
  	du[1] = (r+phi+lambda+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*eta)*u[1] - c - phi*((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*theta)*R - lambda *((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))*u[2]+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*u[3]);
  	du[2] = (r+phi)*u[2] - c - phi*R;
  	du[3] = (r+phi+eta)*u[3] - c - phi*theta*R;
  end


  function f2!(du,u,p,t)
  	q0, r, phi, lambda, eta, c, theta, R = p
  	du[1] = (r+phi+lambda+(1-(q0/(1-q0)*exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*eta)*u[1] - c - phi*((q0/(1-q0)*exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))+(1-(q0/(1-q0)*exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*theta)*R - lambda *((q0/(1-q0)*exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))*u[2]+(1-(q0/(1-q0)*exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*u[3]);
  	du[2] = (r+phi)*u[2] - c - phi*R;
  	du[3] = 0;
  end


  function f3!(du,u,p,t)
  	q0, r, phi, lambda, eta, c, theta, F = p
  	du[1] = (r+phi+lambda+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*eta)*u[1] - c - phi*((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*theta)*F  - lambda *((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))*u[2]+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*u[3]);
  	du[2] = (r+phi)*u[2] - c - phi*F;
  	du[3] = (r+phi+eta)*u[3] - c - phi*theta*F;
  end

  function f4!(du,u,p,t)
	q0, r, phi, lambda, eta, c, theta, F = p
	du[1] = (r+phi+lambda+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*eta)*u[1] - c - phi*((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*theta)*F  - lambda *((q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t)))*u[2]+(1-(q0/(1-q0) * exp(eta*t) / (1+q0/(1-q0)*exp(eta*t))))*L);
	du[2] = (r+phi)*u[2] - c - phi*F;
	du[3] = 0;
  end

	u0   = [Dg*F, 2.0058*F, 0.3083*F]
	p    = (q0, r, phi, lambda, eta, c, phi, theta, R)
	prob = ODEProblem(f!,u0,(tb,tg),p)
	sol  = DifferentialEquations.solve(prob)

	u02  = [0.5709*F, 2.0007*F, L*F]
	p2    = (q0, r, phi, lambda, eta, c, theta, R)
	prob2 = ODEProblem(f2!,u02,(0,tb),p2)
	sol2 = DifferentialEquations.solve(prob2)

	df = hcat([sol2.u; sol.u]...)
	dx = hcat([sol2.t; sol.t]...)

	plot1 = plot(dx',df', title = "Figure 2.a Path of joint continuation value", label = ["Vu" "Vg" "Vb"], lw = 3,legend=:bottomleft);
	xlabel!("t")
	hline!([L], line=(4, :dash, 0.6, :black),label="L")
	# vline!([tb], line=(2, 0.6, :grey),label="tb")
	old_xticks = xticks(plot1[1]) # grab xticks of the 1st subplot
	new_xticks = ([tb, tg], ["tb", "tg"])
	vline!(new_xticks[1], line=(2, 0.6, :grey),label="")
	keep_indices = findall(x -> all(x .≠ new_xticks[1]), old_xticks[1])
	merged_xticks = (old_xticks[1][keep_indices] ∪ new_xticks[1], old_xticks[2][keep_indices] ∪ new_xticks[2])
	xticks!(merged_xticks)

	u03  = [0.6239, 1.0454, L]
	p3    = (q0, r, phi, lambda, eta, c, theta, F)
	prob3 = ODEProblem(f3!,u03,(tb,tg),p3)
	sol3 = DifferentialEquations.solve(prob3)

	u04  = [0.3567, 1.0603, L]
	p4    = (q0, r, phi, lambda, eta, c, theta, F)
	prob4 = ODEProblem(f4!,u04,(0,tb),p4)
	sol4 = DifferentialEquations.solve(prob4)

	dfB = hcat([sol4.u; sol3.u]...)
	dxB = hcat([sol4.t; sol3.t]...)

	plot2 = plot(dxB',dfB', title = "Figure 2.b Path of bank's continuation value", label = ["Bu" "Bg" "Bb"], lw = 3,legend=:bottomleft);
	xlabel!("t")
	hline!([L], line=(4, :dash, 0.6, :black),label="L")
	old_xticks2 = xticks(plot2[1]) # grab xticks of the 1st subplot
	new_xticks2 = ([tb, tg], ["tb", "tg"])
	vline!(new_xticks2[1], line=(2, 0.6, :grey),label="")
	keep_indices2 = findall(x -> all(x .≠ new_xticks2[1]), old_xticks2[1])
	merged_xticks2 = (old_xticks2[1][keep_indices2] ∪ new_xticks2[1], old_xticks2[2][keep_indices2] ∪ new_xticks2[2])
	xticks!(merged_xticks2)

end
