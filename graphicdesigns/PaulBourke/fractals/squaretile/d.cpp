// based on the code by Vort
// https://commons.wikimedia.org/wiki/File:XOR_texture.png
// 

#include <fstream>

int main()
{
	std::ofstream file;
	file.open("x1.ppm");
	int jMax = 1000;
	int iMax = 1000;
	file << "P2 " << jMax << ' ' << iMax <<" 255\n";
	for (int j = 0; j < jMax; j++)
		for (int i = 0; i < iMax; i++){
			int g = ( i & (j - 2*(i^j) + j) & i) % 255;
			file << g << ' ';
			}
	file.close();
	return 0;
}
