#Animation of the Polarization
using Plots
using LaTeXStrings

Ax = 0.5
Ay = 0.5
ω = 1
ϕx = 0 #rads
ϕy = pi #rads

n = 150
t = range(0, 2π, length = n)

#Polarization in z=0 
x = Ax .* cos.(ω.*t .+ ϕx)
y = Ay .* cos.(ω.*t .+ ϕy)

#When we have a ϕy = pi/2, this can be then translated as if we had a sin function instead of a cosine one, that why we get a circle*

#Extracted from documentation of Julia Plots
@userplot CirclePlot
@recipe function f(cp::CirclePlot)
    x, y, i = cp.args
    n = length(x)
    inds = circshift(1:n, 1 - i)
    linewidth --> range(0, 10, length = n)
    seriesalpha --> range(0, 1, length = n)
    aspect_ratio --> 1
    title --> L"Vector de Polarizacion con el Tiempo ($\varphi = %$(round(ϕy-ϕx,digits=2))$ rads)"
    label --> false
    minorgrid --> true
    xlims --> (-2,2)
    ylims --> (-2,2)
    x[inds], y[inds]
end

anim = @animate for i ∈ 1:n
    circleplot(x, y, i)
end
gif(anim, "polarization.gif", fps = 30)
#savefig(anim, "")