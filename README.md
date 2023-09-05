# unicodeMath – write readable LaTeX code

Write readable LaTeX code using the package unicodeMath.
The package maps unicode characters in LaTeX documents.

	\documentclass{article}
	\usepackage[a4paper]{geometry}
	\usepackage{bm}

	%	╭───────────────────────────────────────────────
	%	│	include the package
	\usepackage{unicodeMath}

	\title{	\textbf{What You See Is What You Mean} ⏎
				Writing Unicode in \LaTeX}

	%	╭───────────────────────────────────────────────
	%	│	main document
	\begin{document}
		\maketitle
		The vorticity $ω$ is defined as $ω ≔ ∇ ⨯ u$.
		The derivative of the function
		\begin{align}
			f∶ ℝ₊&→ ℝ₊	⏎
			   x &↦ √x= x^½
		\end{align}
		\[	{∂∕∂x}f(x)= {1 ∕ 2√x}.\]
		The density of the Gaussian distribution with parameters $μ$ and $σ$ is
		\[	φ(x| μ,σ²)= {1∕ √{2πσ²}} e^{-{(x-μ)² ∕ 2σ²}}.\]
		The solutions of the quadratic equation
		\[	α x²+ β x+ γ= 0 \]
		are
		\[	x_± = {-β ± √{β²- 4αγ} ∕ 2α}.\]
		For $s∈ ℂ$ and $ℜ (s)> 1$, it holds that
		\[	ζ(s)Γ(s)= ∫₀᪲ {x^{s-1} ∕ eˣ-1} ⅾx,\]
		where Euler’s integral of the second kind is
		\[	Γ(s)= ∫₀᪲ x^{s-1} e^{-x} ⅾx,\]
		and
		\[	ζ(s)= ∑_{n∈ℕ} {1∕nˢ}\]
		is Riemann’s $ζ$‑function.
	\end{document}


The package as well provides snippets for VS-Code and LuaSnips for (n)vim.
