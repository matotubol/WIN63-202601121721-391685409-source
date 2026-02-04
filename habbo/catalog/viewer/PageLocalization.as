package com.sulake.habbo.catalog.viewer
{
   import flash.utils.Dictionary;
   
   public class PageLocalization implements class_1998
   {
      
      public static const HEADER_IMAGE:String = "catalog.header.image";
      
      public static const const_550:String = "catalog.header.icon";
      
      public static const HEADER_TITLE:String = "catalog.header.title";
      
      public static const const_244:String = "catalog.header.description";
      
      private static const DEFAULT_TEXT_FIELDS:Array = ["catalog.header.description","ctlg_description","ctlg_special_txt","ctlg_text_1","ctlg_text_2"];
      
      private static const DEFAULT_IMAGE_FIELDS:Array = ["catalog.header.image","ctlg_teaserimg_1","ctlg_special_img","ctlg_teaserimg_2","ctlg_teaserimg_3"];
      
      private static const LAYOUTS_IMAGE_FIELDS:Dictionary = new Dictionary();
      
      private static const LAYOUTS_TEXT_FIELDS:Dictionary = new Dictionary();
      
      private static const LAYOUT_LINKS:Dictionary = new Dictionary();
      
      LAYOUTS_IMAGE_FIELDS["frontpage4"] = ["catalog.header.image","ctlg_teaserimg_1"];
      LAYOUTS_TEXT_FIELDS["camera1"] = ["catalog.header.description","ctlg_text_1"];
      LAYOUTS_TEXT_FIELDS["presents"] = ["catalog.header.description","ctlg_text1"];
      LAYOUTS_TEXT_FIELDS["pets"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["pets2"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["pets3"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["info_rentables"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3","ctlg_text_4","ctlg_text_5"];
      LAYOUTS_TEXT_FIELDS["info_duckets"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["info_loyalty"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["trophies"] = ["trophy.description","trophy.enscription"];
      LAYOUTS_TEXT_FIELDS["frontpage4"] = ["ctlg_txt1","ctlg_txt2"];
      LAYOUTS_TEXT_FIELDS["builders_club_frontpage"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["builders_club_addons"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["builders_club_loyalty"] = ["ctlg_description"];
      LAYOUT_LINKS["club_buy"] = ["club_link"];
      LAYOUT_LINKS["mad_money"] = ["ctlg_madmoney_button"];
      LAYOUT_LINKS["monkey"] = ["ctlg_teaserimg_1_region","ctlg_special_img_region"];
      LAYOUT_LINKS["niko"] = ["ctlg_teaserimg_1_region","ctlg_special_img_region"];
      LAYOUT_LINKS["pets3"] = ["ctlg_text_3"];
      
      private var var_602:Array;
      
      private var var_1473:Array;
      
      public function PageLocalization(param1:Array, param2:Array)
      {
         super();
         var_602 = param1;
         var_1473 = param2;
      }
      
      public function get imageCount() : int
      {
         return var_602.length;
      }
      
      public function get textCount() : int
      {
         return var_1473.length;
      }
      
      public function dispose() : void
      {
         var_602 = null;
         var_1473 = null;
      }
      
      public function hasLinks(param1:String) : Boolean
      {
         return LAYOUT_LINKS[param1] != null;
      }
      
      public function getLinks(param1:String) : Array
      {
         return LAYOUT_LINKS[param1];
      }
      
      public function getTextElementName(param1:int, param2:String) : String
      {
         var _loc3_:Array = LAYOUTS_TEXT_FIELDS[param2];
         if(_loc3_ == null)
         {
            _loc3_ = DEFAULT_TEXT_FIELDS;
         }
         if(param1 < _loc3_.length)
         {
            return _loc3_[param1];
         }
         return "";
      }
      
      public function getImageElementName(param1:int, param2:String) : String
      {
         var _loc3_:Array = LAYOUTS_IMAGE_FIELDS[param2];
         if(_loc3_ == null)
         {
            _loc3_ = DEFAULT_IMAGE_FIELDS;
         }
         if(param1 < _loc3_.length)
         {
            return _loc3_[param1];
         }
         return "";
      }
      
      public function getTextElementContent(param1:int) : String
      {
         if(param1 < var_1473.length)
         {
            return var_1473[param1];
         }
         return "";
      }
      
      public function getImageElementContent(param1:int) : String
      {
         if(param1 < var_602.length)
         {
            return var_602[param1];
         }
         return "";
      }
      
      public function getColorUintFromText(param1:int) : uint
      {
         if(param1 < var_1473.length)
         {
            var _loc2_:String = String(var_1473[param1]).replace("#","0x");
            return uint(Number(null));
         }
         return 0;
      }
   }
}

