using Documenter

pages = Any[
    "Home" => "index.md",
    "Publications" => "publications.md"
    ]


mathengine = MathJax(Dict(
    :TeX => Dict(
        :equationNumbers => Dict(:autoNumber => "AMS"),
        :Macros => Dict(),
    ),
))

format = Documenter.HTML(
    prettyurls = get(ENV, "CI", nothing) == "true",
    mathengine = mathengine,
    collapselevel = 1,
)

makedocs(
    sitename = "Yujie's Website",
    format = format,
    clean = false,
    pages = pages
)

deploydocs(
    repo = "github.com/Yujie-W/PAGES.git",
    target = "build",
    push_preview = true,
)
