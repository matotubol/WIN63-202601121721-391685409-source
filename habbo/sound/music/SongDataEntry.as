package com.sulake.habbo.sound.music
{
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_1814;
   import package_154.class_3136;
   
   public class SongDataEntry extends class_3136 implements ISongInfo
   {
      
      private var _soundObject:class_1814 = null;
      
      private var var_3173:String = "";
      
      private var var_4405:int = -1;
      
      public function SongDataEntry(param1:int, param2:int, param3:String, param4:String, param5:class_1814)
      {
         _soundObject = param5;
         super(param1,param2,param3,param4);
      }
      
      override public function get id() : int
      {
         return var_2766;
      }
      
      override public function get length() : int
      {
         return var_3754;
      }
      
      override public function get name() : String
      {
         return _songName;
      }
      
      override public function get creator() : String
      {
         return var_3592;
      }
      
      public function get loaded() : Boolean
      {
         return _soundObject?.ready;
      }
      
      public function get soundObject() : class_1814
      {
         return _soundObject;
      }
      
      public function get songData() : String
      {
         return var_3173;
      }
      
      public function get diskId() : int
      {
         return var_4405;
      }
      
      public function set soundObject(param1:class_1814) : void
      {
         _soundObject = param1;
      }
      
      public function set songData(param1:String) : void
      {
         var_3173 = param1;
      }
      
      public function set diskId(param1:int) : void
      {
         var_4405 = param1;
      }
   }
}

