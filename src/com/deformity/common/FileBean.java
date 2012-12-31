package com.deformity.common;

import java.io.File;

/**
 * 文件处理用Bean
 */
public class FileBean {
    private Long file_id;
    private String[] file_name;
    private String file_note;
    private String object_id;
    private String object_type_id;
    private String file_url;
    private File[] files;

    public Long getFile_id() {
        return file_id;
    }

    public void setFile_id(Long file_id) {
        this.file_id = file_id;
    }

    public String[] getFile_name() {
        return file_name;
    }

    public void setFile_name(String[] file_name) {
        this.file_name = file_name;
    }

    public String getFile_note() {
        return file_note;
    }

    public void setFile_note(String file_note) {
        this.file_note = file_note;
    }

    public String getObject_id() {
        return object_id;
    }

    public void setObject_id(String object_id) {
        this.object_id = object_id;
    }

    public String getObject_type_id() {
        return object_type_id;
    }

    public void setObject_type_id(String object_type_id) {
        this.object_type_id = object_type_id;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public File[] getFiles() {
        return files;
    }

    public void setFiles(File[] files) {
        this.files = files;
    }
}
