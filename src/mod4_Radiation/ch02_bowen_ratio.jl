### A Pluto.jl notebook ###
# v0.19.32

#> [frontmatter]
#> image = "https://user-images.githubusercontent.com/6933510/136199718-ff811eb3-aad6-4d6b-99e0-f6bf922816b4.png"
#> order = 4
#> chapter = 4
#> section = 1
#> title = "Bowen Ratio"
#> layout = "layout.jlhtml"
#> description = ""
#> tags = ["lecture", "module4", "Bowen"]

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 00d7c5f0-8ec0-11ee-231d-499c86ddd433
begin
	using Pkg
	# Pkg.activate(".")
	using HydroTools
	using HydroTools: Cp, ϵ
	using Plots
	using Ipaper
	using PlutoUI
	
	gr(framestyle=:box)
	nothing

	function cal_gamma(Tair, Pa=atm) 
	  lambda = cal_lambda(Tair)
	  Cp * Pa / (ϵ * lambda) # u"kPa / K"
	end

	function cal_bowen(Tair, Pa=atm)
		Δ = cal_slope(Tair)
		γ = cal_gamma(Tair, Pa)
		γ/Δ
	end
	# Pkg.add("PlutoUI")
end

# ╔═╡ 08182ea1-7799-4a07-9c52-79d9dcb3c05c
html"""<style>
main {
    max-width: 1100px;
    //align-self: flex-start;
    margin-left: 50px;
}
"""

# ╔═╡ 71742ea4-4ab6-4e47-8a77-7cd207165282
md"""
Ta = $(@bind Ta Slider(-40:1.0:50; default=25, show_value=true)) ℃
"""

# ╔═╡ 8ae3aa76-e55b-4ad3-906b-069acc0c8d58
cal_lambda(Ta) # MJ /kg

# ╔═╡ da3ad55d-4def-4a7a-96bb-5316930179a9
begin
	T = -40:0.1:40
	es = cal_es.(Ta);
	nothing
end

# ╔═╡ 992a4a18-6290-491a-98b7-f1601cacc3b5
begin
	function draw_plot(;fun=cal_slope, title="Δ of es", unit="kPa/℃")
		p2 = plot(T, fun.(T); 
			title, 
			xlabel = "Tair (℃)", ylabel=unit, label=nothing)
		
		scatter!([Ta], [fun(Ta)], label=nothing)
		vline!([Ta], linestyle=:dash, color=:grey, label=nothing)
		hline!([fun(Ta)], linestyle=:dash, color=:grey, label=nothing)
	
		label2 = @sprintf("(%.2f ℃, %.3f %s)", Ta, fun(Ta), unit)
		annotate!(Ta, fun(Ta), text(label2, :red, :right, :bottom, 12))
		p2
	end
end

# ╔═╡ 8d204760-cc67-4be0-a6ff-d3e893e8c198
begin
	p_es = draw_plot(; fun=cal_es, title="es", unit="kPa")
	p_slope = draw_plot(; fun=cal_slope, title="Δ", unit="kPa/℃")
	p_gamma = draw_plot(; fun=cal_gamma, title="γ", unit="kPa/℃")
	p_bowen = draw_plot(; fun=cal_bowen, title="bowen=γ/Δ", unit="")
	plot(p_es, p_slope, p_gamma, p_bowen,  size=(800,700))
end

# ╔═╡ Cell order:
# ╠═00d7c5f0-8ec0-11ee-231d-499c86ddd433
# ╟─08182ea1-7799-4a07-9c52-79d9dcb3c05c
# ╠═71742ea4-4ab6-4e47-8a77-7cd207165282
# ╠═8d204760-cc67-4be0-a6ff-d3e893e8c198
# ╠═8ae3aa76-e55b-4ad3-906b-069acc0c8d58
# ╟─da3ad55d-4def-4a7a-96bb-5316930179a9
# ╠═992a4a18-6290-491a-98b7-f1601cacc3b5
