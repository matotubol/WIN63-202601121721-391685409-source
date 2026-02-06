package com.sulake.habbo.communication.messages.incoming.navigator
{
   [SecureSWF(rename="true")]
   public class class_3564
   {
      
      public static const const_69:int = 0;
      
      public static const const_98:int = 1;
      
      public static const const_95:int = 2;
      
      public static const const_107:int = 3;
      
      public static const const_83:int = 4;
      
      private var var_5125:Boolean;
      
      private var var_4157:int;
      
      private var var_197:int;
      
      private var _ownerName:String;
      
      private var var_230:String;
      
      private var _name:String;
      
      private var var_735:String;
      
      private var var_4553:Boolean;
      
      private var var_4910:Boolean;
      
      private var var_4170:Boolean;
      
      private var var_2861:String;
      
      public function class_3564()
      {
         super();
      }
      
      public function get allowFurniMoving() : Boolean
      {
         return var_5125;
      }
      
      public function get doorMode() : int
      {
         return var_4157;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get showOwnerName() : Boolean
      {
         return var_4553;
      }
      
      public function get allowTrading() : Boolean
      {
         return var_4910;
      }
      
      public function get categoryAlertKey() : Boolean
      {
         return var_4170;
      }
      
      public function get password() : String
      {
         return var_2861;
      }
      
      public function set allowFurniMoving(param1:Boolean) : void
      {
         var_5125 = param1;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_4157 = param1;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set type(param1:String) : void
      {
         var_230 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function set showOwnerName(param1:Boolean) : void
      {
         var_4553 = param1;
      }
      
      public function set allowTrading(param1:Boolean) : void
      {
         var_4910 = param1;
      }
      
      public function set categoryAlertKey(param1:Boolean) : void
      {
         var_4170 = param1;
      }
      
      public function set password(param1:String) : void
      {
         var_2861 = param1;
      }
   }
}

