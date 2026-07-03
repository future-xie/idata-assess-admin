package com.rutong.framework.utils.file;

import com.rutong.framework.utils.StringUtils;
import com.rutong.framework.utils.sign.Md5Util;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.URLConnection;
import java.util.UUID;

public class FileUtils {
	private static Logger log = LoggerFactory.getLogger(FileUtils.class);

	private static int counter = 0;

	public static final String IMAGE_PNG = "image/png";
	public static final String IMAGE_JPG = "image/jpg";
	public static final String IMAGE_JPEG = "image/jpeg";
	public static final String IMAGE_BMP = "image/bmp";
	public static final String IMAGE_GIF = "image/gif";

	/**
	 * 编码文件名
	 */
	public static String encodingFilename(String fileName) {
		fileName = fileName.replace("_", " ");
		fileName = Md5Util.hash(fileName + System.nanoTime() + counter++);
		return fileName;
	}
	
	public static String encodingExcelFilename(String filename){
		filename = UUID.randomUUID().toString() + "_" + filename + ".xlsx";
		return filename;
	}

	/**
	 * 获取文件名的后缀
	 *
	 * @param file 表单文件
	 * @return 后缀名
	 */
	public static final String getExtension(MultipartFile file) {
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		if (StringUtils.isEmpty(extension)) {
			extension = getExtension(file.getContentType());
		}
		return extension;
	}

	public static String getExtension(String urlPrefix) {
		switch (urlPrefix) {
		case IMAGE_PNG:
			return "png";
		case IMAGE_JPG:
			return "jpg";
		case IMAGE_JPEG:
			return "jpeg";
		case IMAGE_BMP:
			return "bmp";
		case IMAGE_GIF:
			return "gif";
		default:
			return "";
		}
	}

	/**
	 * 创建文件及其父目录，如果这个文件存在，直接返回这个文件<br>
	 * 此方法不对File对象类型做判断，如果File不存在，无法判断其类型
	 *
	 * @param fullFilePath 文件的全路径，使用POSIX风格
	 * @return 文件，若路径为null，返回null
	 */
	public static File touch(String fullFilePath) {
		if (fullFilePath == null) {
			return null;
		}
		return touch(file(fullFilePath));
	}

	/**
	 * 创建文件及其父目录，如果这个文件存在，直接返回这个文件<br>
	 * 此方法不对File对象类型做判断，如果File不存在，无法判断其类型
	 *
	 * @param file 文件对象
	 * @return 文件，若路径为null，返回null
	 */
	public static File touch(File file) {
		if (null == file) {
			return null;
		}
		if (false == file.exists()) {
			mkParentDirs(file);
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return file;
	}

	/**
	 * 创建所给文件或目录的父目录
	 *
	 * @param file 文件或目录
	 * @return 父目录
	 */
	public static File mkParentDirs(File file) {
		if (null == file) {
			return null;
		}
		return mkdir(file.getParentFile());
	}

	/**
	 * 创建父文件夹，如果存在直接返回此文件夹
	 *
	 * @param path 文件夹路径，使用POSIX格式，无论哪个平台
	 * @return 创建的目录
	 */
	public static File mkParentDirs(String path) {
		if (path == null) {
			return null;
		}
		return mkParentDirs(file(path));
	}

	/**
	 * 创建文件夹，会递归自动创建其不存在的父文件夹，如果存在直接返回此文件夹<br>
	 * 此方法不对File对象类型做判断，如果File不存在，无法判断其类型
	 *
	 * @param dir 目录
	 * @return 创建的目录
	 */
	public static File mkdir(File dir) {
		if (dir == null) {
			return null;
		}
		if (false == dir.exists()) {
			dir.mkdirs();
		}
		return dir;
	}

	/**
	 * 创建File对象
	 *
	 * @param path 文件路径
	 * @return File
	 */
	public static File file(String path) {
		if (null == path) {
			return null;
		}
		return new File(path);
	}

	/**
	 * 获得输入流
	 *
	 * @param path 文件路径
	 * @return 输入流
	 * @throws FileNotFoundException
	 */
	public static BufferedInputStream getInputStream(String path) throws FileNotFoundException {
		return getInputStream(file(path));
	}

	/**
	 * 获得输入流
	 *
	 * @param file 文件
	 * @return 输入流
	 * @throws FileNotFoundException
	 */
	public static BufferedInputStream getInputStream(File file) throws FileNotFoundException {
		return new BufferedInputStream(new FileInputStream(file));
	}

	/**
	 * 判断文件是否存在，如果path为null，则返回false
	 *
	 * @param path 文件路径
	 * @return 如果存在返回true
	 */
	public static boolean exist(String path) {
		return (null != path) && file(path).exists();
	}

	/**
	 * 文件视图下载
	 * 
	 * @param response
	 * @param fileName
	 * @param in
	 * @throws IOException
	 */
	public static void fileDownload(HttpServletResponse response, String fileName, InputStream in) throws IOException {
		String mimeType = getMimeType(fileName);
		// 下载的文件携带这个名称
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		response.setContentType(mimeType);
		byte[] buffer = new byte[1024];
		ByteArrayOutputStream bos = new ByteArrayOutputStream(in.available());
		int len = 0;
		while (-1 != (len = in.read(buffer, 0, buffer.length))) {
			bos.write(buffer, 0, len);
		}
		log.info("==============================下载包长度:!" + bos.size() + "   ========================");
		response.setHeader("Content-Length", bos.size() + "");
		in.close();
		ServletOutputStream sos = response.getOutputStream();
		try {
			sos.write(bos.toByteArray());
			sos.flush();
			sos.close();
		} catch (Exception e) {
		}
		log.info("==============================下载完成![" + fileName + "]   ========================");
	}

	/**
	 * 根据文件扩展名获得MimeType
	 *
	 * @param filePath 文件路径或文件名
	 * @return MimeType
	 * @since 4.1.15
	 */
	public static String getMimeType(String filePath) {
		return URLConnection.getFileNameMap().getContentTypeFor(filePath);
	}

	public static String extName(String fileName) {
		if (fileName == null) {
			return null;
		}
		int index = fileName.lastIndexOf(".");
		if (index == -1) {
			return "";
		} else {
			String ext = fileName.substring(index + 1);
			// 扩展名中不能包含路径相关的符号
			return ext;
		}
	}

	public static void apkDownload(HttpServletResponse response, String fileName, InputStream in) throws IOException {
		// 下载的文件携带这个名称
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		response.setContentType("application/vnd.android.package-archive");
		byte[] buffer = new byte[1024];
		ByteArrayOutputStream bos = new ByteArrayOutputStream(in.available());
		int len = 0;
		while (-1 != (len = in.read(buffer, 0, buffer.length))) {
			bos.write(buffer, 0, len);
		}
		log.info("==============================下载包长度:!" + bos.size() + "   ========================");
		response.setHeader("Content-Length", bos.size() + "");
		in.close();
		ServletOutputStream sos = response.getOutputStream();
		try {
			sos.write(bos.toByteArray());
			sos.flush();
			sos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		log.info("==============================下载完成![" + fileName + "]   ========================");
	}
}
