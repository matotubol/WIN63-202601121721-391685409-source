package com.sulake.habbo.communication.login
{
   public class AvatarData
   {
      
      private var var_197:int;
      
      private var var_3970:String;
      
      private var _name:String;
      
      private var var_3144:String;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var _head_figure:String;
      
      private var _last_access:int;
      
      private var var_5258:Boolean;
      
      private var var_5274:Boolean;
      
      private var _creationTime:String;
      
      public function AvatarData(param1:Object)
      {
         super();
         if(param1 != null)
         {
            var_3970 = param1.uniqueId;
            _name = param1.name;
            var_3144 = param1.motto;
            var_975 = param1.figureString;
            var_111 = param1.gender;
            _last_access = param1.lastWebAccess;
            var_5258 = param1.habboClubMember == "true";
            var_5274 = param1.buildersClubMember == "true";
            _creationTime = param1.creationTime;
         }
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function get uniqueId() : String
      {
         return var_3970;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get head_figure() : String
      {
         return _head_figure;
      }
      
      public function get last_access() : int
      {
         return _last_access;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}

