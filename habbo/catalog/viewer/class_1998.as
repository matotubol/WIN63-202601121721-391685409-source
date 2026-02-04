package com.sulake.habbo.catalog.viewer
{
   public interface class_1998
   {
      
      function get imageCount() : int;
      
      function get textCount() : int;
      
      function getTextElementName(param1:int, param2:String) : String;
      
      function getImageElementName(param1:int, param2:String) : String;
      
      function getTextElementContent(param1:int) : String;
      
      function getImageElementContent(param1:int) : String;
      
      function dispose() : void;
      
      function hasLinks(param1:String) : Boolean;
      
      function getLinks(param1:String) : Array;
      
      function getColorUintFromText(param1:int) : uint;
   }
}

