package com.sulake.room.object
{
   import com.sulake.core.utils.class_55;
   
   public interface IRoomObjectModel
   {
      
      function hasNumber(param1:String) : Boolean;
      
      function hasNumberArray(param1:String) : Boolean;
      
      function hasString(param1:String) : Boolean;
      
      function hasStringArray(param1:String) : Boolean;
      
      function getNumber(param1:String) : Number;
      
      function getString(param1:String) : String;
      
      function getNumberArray(param1:String) : Array;
      
      function getStringArray(param1:String) : Array;
      
      function getUpdateID() : int;
      
      function getStringToStringMap(param1:String) : class_55;
   }
}

