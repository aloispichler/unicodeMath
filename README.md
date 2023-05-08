# unicodeMath – write readable LaTeX code

Write readable LaTeX code using the package unicodeMath.
The package maps unicode characters in LaTeX documents.

    \usepackage{unicodeMath}
    
    \begin{document}
        The vorticity $ω$ is defined as $ω ≔ ∇⨯ u$.

        The solutions of the quadratic equation
	    \[	α x²+ β x+ γ= 0 \]
        are given by
        \[	x_±= -\frac{β ∓ √{β² - 4αγ}}{2α}.\]   
    \end{document}

The package as well provides snippets for VS-Code and LuaSnips for (n)vim.
