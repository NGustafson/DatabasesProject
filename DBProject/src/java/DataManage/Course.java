/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataManage;

/**
 *
 * @author Nick
 */
public class Course {
    
    private String CRN;
    private String CourseNum;
    private String CourseTitle;
    private String Type;
    private String Days;
    private int Units;
    private String BldgRm;
    private String StartEnd;
    private String Time;
    private String Instructor;
    
    
    public Course() {
        
    }

    public String getCRN() {
        return CRN;
    }

    public void setCRN(String CRN) {
        this.CRN = CRN;
    }

    public String getCourseNum() {
        return CourseNum;
    }

    public void setCourseNum(String CourseNum) {
        this.CourseNum = CourseNum;
    }

    public String getCourseTitle() {
        return CourseTitle;
    }

    public void setCourseTitle(String CourseTitle) {
        this.CourseTitle = CourseTitle;
    }

    public String getType() {
        return Type;
    }

    public void setType(String Type) {
        this.Type = Type;
    }

    public String getDays() {
        return Days;
    }

    public void setDays(String Days) {
        this.Days = Days;
    }

    public int getUnits() {
        return Units;
    }

    public void setUnits(int Units) {
        this.Units = Units;
    }

    public String getBldgRm() {
        return BldgRm;
    }

    public void setBldgRm(String BldgRm) {
        this.BldgRm = BldgRm;
    }

    public String getStartEnd() {
        return StartEnd;
    }

    public void setStartEnd(String StartEnd) {
        this.StartEnd = StartEnd;
    }

    public String getTime() {
        return Time;
    }

    public void setTime(String Time) {
        this.Time = Time;
    }

    public String getInstructor() {
        return Instructor;
    }

    public void setInstructor(String Instructor) {
        this.Instructor = Instructor;
    }
    
    
}
