/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Quocb
 */
public class game {
    private int Magame;
    private String tengame;
    private String link;
    private String linkimg;
    private String  theloai;

    public game() {}
    
    public game(int Magame, String tengame, String link, String linkimg, String theloai) {
        this.Magame = Magame;
        this.tengame = tengame;
        this.link = link;
        this.linkimg = linkimg;
        this.theloai = theloai;
    }

    public String getLinkimg() {
        return linkimg;
    }

    public void setLinkimg(String linkimg) {
        this.linkimg = linkimg;
    }

   

    public int getMagame() {
        return Magame;
    }

    public void setMagame(int Magame) {
        this.Magame = Magame;
    }

    public String getTengame() {
        return tengame;
    }

    public void setTengame(String tengame) {
        this.tengame = tengame;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getTheloai() {
        return theloai;
    }

    public void setTheloai(String theloai) {
        this.theloai = theloai;
    }

    @Override
    public String toString() {
        return "game{" + "Magame=" + Magame + ", tengame=" + tengame + ", link=" + link + ", linkimg=" + linkimg + ", theloai=" + theloai + '}';
    }

     
}
