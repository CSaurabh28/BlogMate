package com.blogmaker.entities;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class FileHelper {
	public static boolean deleteFile(String path) {
		boolean f=false;
		try {
				File file=new File(path);
				file.delete();
				} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public static boolean saveFile(InputStream is,String path) {
		boolean f=false;
		try {
				byte[] b=new byte[is.available()];
				is.read(b);
				FileOutputStream fs=new FileOutputStream(path);
				fs.write(b);
				fs.flush();
				fs.close();
				f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
		
	}
}
