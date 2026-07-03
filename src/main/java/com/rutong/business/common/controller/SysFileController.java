package com.rutong.business.common.controller;

import com.rutong.configuration.ApplicationConfig;
import com.rutong.framework.bean.AjaxResult;
import com.rutong.framework.constant.Constants;
import com.rutong.framework.utils.file.FileUtils;
import com.rutong.business.system.entity.SysFile;
import com.rutong.business.system.service.SysFileService;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 上传图片返回图片路径
 */
@RestController
@RequestMapping(value = "/sys/file")
public class SysFileController {

    @Autowired
    private SysFileService sysFileService;

    /**
     * 系统上传组件上传文件接口 支持上传OSS
     *
     * @param file
     * @return
     */
    @PostMapping(value = "/upload")
    public AjaxResult uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            String attachPath = ApplicationConfig.ATTACH_DIR_PATH;
            String fileName = file.getOriginalFilename();
            // 文件名称
            String fileMd5 = FileUtils.encodingFilename(fileName);
            String extension = FileUtils.getExtension(file);
            // 文件相对路径
            String relativePath = "file/" + DateFormatUtils.format(new Date(), "yyyy/MM/dd") + "/" + fileMd5 + "."
                    + extension;
            SysFile sysFile = new SysFile();
            sysFile.setFilePath(relativePath);
            sysFile.setFileName(fileName);
            sysFile.setFileType(extension);
            sysFile.setFileMd5(fileMd5);
            sysFile.setFileSize(new BigDecimal(file.getSize()));

            attachPath = attachPath + relativePath;
            File file0 = FileUtils.touch(attachPath);
            file.transferTo(file0);

            sysFileService.insert(sysFile);
            return AjaxResult.success().put("path", ApplicationConfig.PROFILE_URL + relativePath).put("fileName", fileName)
                    .put("id", sysFile.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error(e.getMessage());
        }
    }

    @RequestMapping("/downloadFile")
    public void fileDownload(HttpServletResponse response, @RequestParam("fileId") Long fileId) {
        try {
            SysFile file = sysFileService.findById(fileId);
            if (null == file) {
                return;
            }
            String relativePath = file.getFilePath();
            InputStream inputStream = null;
            String filePath = ApplicationConfig.ATTACH_DIR_PATH + relativePath;
            if (!FileUtils.exist(filePath)) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("文件不存在");
                return;
            }
            inputStream = FileUtils.getInputStream(filePath);
            // 转换视图
            String fileName = new String(file.getFileName().getBytes("UTF-8"), "ISO-8859-1");
            FileUtils.fileDownload(response, fileName, inputStream);
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
