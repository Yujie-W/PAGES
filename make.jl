using Documenter


# Pages to generate
pages = Pair{Any,Any}[
    "Home"          => "index.md"        ,
    "Projects"      => "projects.md"     ,
    "Methods"       => "methods.md"      ,
    "Publications"  => "publications.md" ,
    "Datasets"      => "datasets.md"     ,
    "Posters"       => "posters.md"      ,
    "Seminars"      => "seminars.md"     ,
    "Dissertations" => "dissertations.md",
];


# format the docs
mathengine = MathJax(Dict(:TeX => Dict(:equationNumbers => Dict(:autoNumber => "AMS"), :Macros => Dict())));
format = (Documenter).HTML(prettyurls    = get(ENV, "CI", nothing)=="true",
                           mathengine    = mathengine,
                           collapselevel = 1,
                           assets        = ["assets/favicon.ico"]);


# build the docs
makedocs(
    sitename = "Yujie's Website",
    format = format,
    clean = false,
    pages = pages
);


# function to replace strings
function replace_html(file_name::String)
    list_str   = readlines(file_name);
    file_write = open(file_name, "w");
    for i in eachindex(list_str)
        list_str[i] = replace(list_str[i], "<p>&lt;details&gt; &lt;summary&gt;" => "<details><summary>");
        list_str[i] = replace(list_str[i], "&lt;/summary&gt;</p>" => "</summary>");
        list_str[i] = replace(list_str[i], "<p>&lt;/details&gt;</p>" => "</details>");
        write(file_write, list_str[i] * "\n");
    end

    return nothing
end


# Replace the strings
for page_name in ["publications", "datasets"]
    file_name = joinpath(@__DIR__, "build/$(page_name).html");
    if isfile(file_name)
        replace_html(file_name);
    else
        file_name = joinpath(@__DIR__, "build/$(page_name)/index.html");
        if isfile(file_name)
            replace_html(file_name);
        else
            @warn "No file found to work on, please check file names";
        end
    end
end


# Deploy docs
deploydocs(
    repo = "github.com/Yujie-W/PAGES.git",
    target = "build",
    devbranch = "main",
    push_preview = true,
);
