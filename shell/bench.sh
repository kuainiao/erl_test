for threads in  1 2 3 4
do
	env OMP_NUM_THREADS=$threads
	gm benchmark -duration 10 convert \
		-size 2048×1080 pattern:granite -operator all Noise-Gaussian 30% null:
done
