using Documenter

pages = Any[
    "Home"          => "index.md"        ,
    "Projects"      => "projects.md"     ,
    "Publications"  => "publications.md" ,
    "Dissertations" => "dissertations.md",
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

@show pwd();
@show readdir("build/publications");

# replace strings in files and write to file
list_str   = readlines("build/publications/index.html");
file_write = open("build/publications/index.html", "w");
for i in eachindex(list_str)
    list_str[i] = replace(list_str[i], "<p>&lt;details&gt; &lt;summary&gt;" => "<details><summary>");
    list_str[i] = replace(list_str[i], "&lt;/summary&gt;</p>" => "</summary>");
    list_str[i] = replace(list_str[i], "<p>&lt;/details&gt;</p>" => "</details>");
    write(file_write, list_str[i] * "\n");
end
close(file_write);

deploydocs(
    repo = "github.com/Yujie-W/PAGES.git",
    target = "build",
    push_preview = true,
)
