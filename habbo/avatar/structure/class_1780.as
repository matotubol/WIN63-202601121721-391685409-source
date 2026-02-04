package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_1932;
   import com.sulake.habbo.avatar.structure.figure.class_2017;
   
   public interface class_1780
   {
      
      function getSetType(param1:String) : ISetType;
      
      function getPalette(param1:int) : class_2017;
      
      function getFigurePartSet(param1:int) : class_1932;
   }
}

