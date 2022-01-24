push!(LOAD_PATH,"../src/")
using Documenter, Hu_Varas_majoarteaga

makedocs(modules = [Hu_Varas_majoarteaga], sitename = "Hu_Varas_majoarteaga.jl")

deploydocs(repo = "github.com/majoarteaga/Hu_Varas_majoarteaga.jl.git", devbranch = "main")
