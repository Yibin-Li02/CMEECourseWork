# Final Assessment - Yibin

- The overall structure was well-maintained, with clearly named weekly directories and essential files like `.gitignore` and `README.md` present in the root directory. - The README files in the weekly folders consistently outlined dependencies, descriptions, and data files.
- Week-by-week enhancements were noticeable in the clarity and completeness of README files, especially regarding dependencies and file descriptions. However, Week 1's README lacked detailed explanations compared to later weeks.
- The `.gitignore` file improved by including relevant patterns for R, Python, and other potential files. You could have done with more exclusions specific to certain weeks (remember that you can include/exclude subdirectories/files/patterns). You may [find this useful](https://www.gitignore.io).
- Scripts across weeks were well-structured and adhered to coding conventions. For instance, Week 3's R scripts demonstrated appropriate use of functions, comments, and preallocation.
- Error handling was introduced in Week 2 scripts like `control_flow.py`, but Week 3's R scripts largely lacked similar safeguards.
- Naming conventions for variables and functions became more consistent over the weeks, good.

## Week 1
 Unix scripts were simple but effective. The README described dependencies and contents adequately.
- Missing docstrings in scripts like `example.sh`. Some comments were overly terse, reducing clarity.

## Week 2
- Some scripts (`cfexercises1.py`, `debugme.py`) lacked error handling, making debugging challenging during unexpected inputs.

## Week 3
- Scripts like `TreeHeight.R` missed meaningful comments about calculations. Error handling was still absent.

## Week 4
- Scripts demonstrated improved modularity.
- The script for Florida autocorrelation was logically structured, leveraging R's capabilities for statistical modeling and visualization. The script could have benefited from more inline comments to explain steps, particularly the choice of statistical methods.
- The report was well-organized but lacked sufficient context for key visualizations. Additional annotations or discussions on the significance of observed trends would have strengthened the report.

## Git Practices
- Commit messages were detailed and reflected meaningful changes, such as "Added error handling for Week 2 Python scripts." 
- By Week 4, the repository reached ~2.5 MiB, which is manageable. However, including binary files like `.RData` in some weeks unnecessarily inflated the size.
- The repository saw significant refinements, such as a cleaner `.gitignore` and modular commits, over the weeks.
- Your Groupwork practicals were all in order, and your group did well in collaborating on it based on the commit/merge/pull history. Check the groupwork feedback pushed to your group repo for more details.   
- The Autocorrelation practical was fine -- the code  was reasonably efficient , whilst providing a correct answer to the question. The  provided statistical and biological/ecological interpretations in the report could have been stronger; has a somewhat weak conclusion at the end.

## Overall Assessment

Overall, a very good job! 

I was impressed by your efforts to understand as many details of the programming languages and coding as possible.

Commenting could be improved -- you are currently erring on the side of overly verbose comments at times (including in your readmes), which is nonetheless better than not commenting at all, or too little! This will improve with experience, as you will begin to get a feel of what is ``common-knowledge'' among programmers, and what stylistic idioms are your own and require explanation. In general though, comments should be written to help explain a coding or syntactical decision to a user (or to your future self re-reading the code!) rather than to describe the meaning of a symbol, argument or function (that should be in the function docstring in Python for example).

It was a tough set of weeks, but I believe your hard work in them has given you a great start towards further training, a quantitative masters dissertation, and ultimately a career in quantitative biology! 

### (Provisional) Mark

 *75*