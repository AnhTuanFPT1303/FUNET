/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quocb
 */
public class Month {
    private String Name;
    private Integer Count;

    public Month(String Name, Integer Count) {
        this.Name = Name;
        this.Count = Count;
    }

    public Month() {
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public Integer getCount() {
        return Count;
    }

    public void setCount(Integer Count) {
        this.Count = Count;
    }

    @Override
    public String toString() {
        return "Month{" + "Name=" + Name + ", Count=" + Count + '}';
    }
    
}
