*************README*************

1、综合报告的pdf文件

********************************

2、“program”文件夹
	2.1 main.m为本次结果所使用主程序
	2.2 pics文件夹中图片为程序所需图片
	2.3 各个子程序功能说明（以名称排序）,具体功能与调用方式详见报告第五部分“程序结构”。
		gsolve.m		求解特征函数g
		hdr.m			运用HDR算法获得“光亮图谱(radiance map)
		makeImageMatrix.m	从6张图像中采样204个点并记入一个矩阵中
		makeLuminanceMap.m	根据求解公式luminance=0.2125hdrR+0.7154*hdrG+0.0721*hdrB，获得光照图
		readDir.m		图像读取
		reinhardGlobal.m	获得结果，参考了柏林工业大学Mathias Eitz教授的代码，在参考文献中加以注明
		rgbSample.m		RGB三通道分别采样

********************************

3、“处理结果”文件夹
	3.1 “原始图片”文件夹：6张原始图片
	3.2 “HDR处理结果”文件夹：HDR处理结果