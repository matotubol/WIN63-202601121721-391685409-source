package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class class_3157
   {
      
      private var var_197:int = 0;
      
      private var var_4231:Boolean = false;
      
      private var var_4844:int = 0;
      
      private var var_4746:int = 0;
      
      private var var_4280:int = 0;
      
      private var var_3917:int = 0;
      
      private var var_26:Number = 0;
      
      private var var_176:Number = 0;
      
      private var var_772:String = "";
      
      private var var_230:int = 0;
      
      private var var_61:int = 0;
      
      private var var_24:String = "";
      
      private var var_136:Boolean = false;
      
      private var var_4056:int = 0;
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_2008:int;
      
      public function class_3157(param1:int, param2:int, param3:Boolean)
      {
         super();
         var_197 = param1;
         var_230 = param2;
         var_4231 = param3;
      }
      
      public function setReadOnly() : void
      {
         var_136 = true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get isOldFormat() : Boolean
      {
         return var_4231;
      }
      
      public function get wallX() : Number
      {
         return var_4844;
      }
      
      public function set wallX(param1:Number) : void
      {
         if(!var_136)
         {
            var_4844 = param1;
         }
      }
      
      public function get wallY() : Number
      {
         return var_4746;
      }
      
      public function set wallY(param1:Number) : void
      {
         if(!var_136)
         {
            var_4746 = param1;
         }
      }
      
      public function get localX() : Number
      {
         return var_4280;
      }
      
      public function set localX(param1:Number) : void
      {
         if(!var_136)
         {
            var_4280 = param1;
         }
      }
      
      public function get localY() : Number
      {
         return var_3917;
      }
      
      public function set localY(param1:Number) : void
      {
         if(!var_136)
         {
            var_3917 = param1;
         }
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_136)
         {
            var_26 = param1;
         }
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_136)
         {
            var_176 = param1;
         }
      }
      
      public function get dir() : String
      {
         return var_772;
      }
      
      public function set dir(param1:String) : void
      {
         if(!var_136)
         {
            var_772 = param1;
         }
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function set type(param1:int) : void
      {
         if(!var_136)
         {
            var_230 = param1;
         }
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function set state(param1:int) : void
      {
         if(!var_136)
         {
            var_61 = param1;
         }
      }
      
      public function get data() : String
      {
         return var_24;
      }
      
      public function set data(param1:String) : void
      {
         if(!var_136)
         {
            var_24 = param1;
         }
      }
      
      public function get usagePolicy() : int
      {
         return var_4056;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         if(!var_136)
         {
            var_4056 = param1;
         }
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function set ownerId(param1:int) : void
      {
         if(!var_136)
         {
            var_1820 = param1;
         }
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         if(!var_136)
         {
            _ownerName = param1;
         }
      }
      
      public function get secondsToExpiration() : int
      {
         return var_2008;
      }
      
      public function set secondsToExpiration(param1:int) : void
      {
         if(!var_136)
         {
            var_2008 = param1;
         }
      }
   }
}

