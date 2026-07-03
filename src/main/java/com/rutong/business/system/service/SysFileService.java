package com.rutong.business.system.service;

import com.rutong.business.common.service.BaseService;
import com.rutong.business.system.entity.SysFile;
import com.rutong.configuration.ApplicationConfig;
import com.rutong.framework.utils.file.FileUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class SysFileService extends BaseService<SysFile> {

    /**
     * 上传文件：写入磁盘并落 sys_file，返回 {id, fileName, path, url}。
     * 使用 insertNoAuth（不依赖登录用户），故可供免登的问卷填写端调用。
     */
    public Map<String, Object> upload(MultipartFile file) throws Exception {
        String fileName = file.getOriginalFilename();
        String fileMd5 = FileUtils.encodingFilename(fileName);
        String extension = FileUtils.getExtension(file);
        String relativePath = "file/" + DateFormatUtils.format(new Date(), "yyyy/MM/dd") + "/" + fileMd5 + "." + extension;

        SysFile sysFile = new SysFile();
        sysFile.setFilePath(relativePath);
        sysFile.setFileName(fileName);
        sysFile.setFileType(extension);
        sysFile.setFileMd5(fileMd5);
        sysFile.setFileSize(new BigDecimal(file.getSize()));

        File dest = FileUtils.touch(ApplicationConfig.ATTACH_DIR_PATH + relativePath);
        file.transferTo(dest);
        insertNoAuth(sysFile); // 不写 createBy，避免免登场景下获取登录用户异常

        Map<String, Object> result = new HashMap<>();
        result.put("id", sysFile.getId());
        result.put("fileName", fileName);
        result.put("path", relativePath);
        result.put("url", ApplicationConfig.PROFILE_URL + relativePath);
        return result;
    }
}
