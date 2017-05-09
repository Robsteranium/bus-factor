# Calculate your Bus Factor - An introduction to GNU-R

!(thumbnail ./slides/pictures/thumbnail.png) This repo contains both the code for calculating your bus factor and the slides from the presentation.

## Calculating your Bus Factor

### Install R and RStudio

Install [R](https://cran.r-project.org/) and the [RStudio graphical user interface](https://www.rstudio.com/products/rstudio/download/) then start RStudio.

Windows users:

- [Download R for Windows](https://cran.r-project.org/bin/windows/base/R-3.3.3-win.exe)
- [Download RStudio for Windows](https://download1.rstudio.org/RStudio-1.0.136.exe)

Mac users:

- [Download R for Mavericks](https://cran.r-project.org/bin/macosx/R-3.3.3.pkg)
- [Download RStudio for OSX 10.6+](https://download1.rstudio.org/RStudio-1.0.136.dmg)

Linux users:

- [R binary packages](https://cran.r-project.org/bin/linux/) or search your package manager (e.g. `r-base` in ubuntu)
- [RStudio binaries](https://www.rstudio.com/products/rstudio/download/)

### Running the script

Once you've got R and Rstudio running, you can open up the two files in the [code](./code) directory:

- [bus-factor.r](./code/bus-factor.r) provides the functions required to extract and aggregate the authorship data and calculate the bus factor;
- [plot.r](./code/plot.r) provides an example of how to call those functions and plot a chart showing the relative contribution of different authors.

You'll need to point the function at a git repository. You may find R's `getwd` and `setwd` commands useful for navigating your file system.

## Building the Slides

The slides are build with the [Shower Framework](http://shwr.me) with an extra gulp task for converting haml to html.

To rebuild the slides:

    cd slides
    npm install
    gulp prepare

Optionally you can use `gulp watch` to have them automatically rebuilt every time you save the `index.haml` or `css/extra.css` files.

Shower is released under the MIT License.

## History

This talk is based upon an article I wrote for Linux Voice Magazine.

## License

The code and slides are made available under a Creative Commons Attribution Sharealike License (CC-BY-SA).
