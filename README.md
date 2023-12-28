# unicodeMath – write readable LaTeX code

Write human readable LaTeX code (what you see is what you mean) using the package unicodeMath.
The package maps unicode characters in LaTeX documents.
As well, the packages provides snippets for VS-Code and (n)vim.

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
		The vorticity $ω$ is defined as $ω≔ ∇ × u$.
		The derivative of the radial function
		\begin{align}
			f∶ ℝᵈ₊ &→ ℝ₊	⏎
			   𝐱   &↦ fᵣ(‖𝐱‖)
		\end{align}
		is
		\[	{∂∕∂xᵢ}f(𝐱)= fᵣ′(𝐱){xᵢ ⁄ ‖𝐱‖}.\]
		The density of the Gaussian distribution with parameters $μ$ and $σ²$ is
		\[	φ(x| μ,σ²)= {1 ⁄ √{2πσ²}} e^{-{(x-μ)² ⁄ 2σ²}}.\]
		The solutions of the quadratic equation
		\[	α x²+ β x+ γ= 0 \]
		are
		\[	x_± = {-β ± √{β²- 4αγ} ⁄ 2α}.\]
		For $s∈ ℂ$ and $ℜ (s)> 1$, it holds that
		\[	ζ(s)Γ(s)= ∫₀᪲ {x^{s-1} ⁄ eˣ-1} ⅾx,\]
		where Euler’s integral of the second kind is
		\[	Γ(s)= ∫₀᪲ x^{s-1} e^{-x} ⅾx,\]
		and
		\[	ζ(s)= ∑_{n∈ℕ} {1 ⁄ nˢ}\]
		is Riemann’s $ζ$‑function.
	\end{document}
