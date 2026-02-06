package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.class_2108;
   
   [SecureSWF(rename="true")]
   public class class_3647
   {
      
      private var var_197:int = 0;
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_176:Number = 0;
      
      private var var_772:int = 0;
      
      private var var_1132:int = 0;
      
      private var var_1224:int = 0;
      
      private var var_2640:Number = 0;
      
      private var var_230:int = 0;
      
      private var var_3221:int = -1;
      
      private var var_61:int = 0;
      
      private var var_24:IStuffData = new class_2108();
      
      private var _expiryTime:int = 0;
      
      private var var_4056:int;
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4196:String = null;
      
      private var var_136:Boolean = false;
      
      private var var_2271:Boolean = false;
      
      public function class_3647(param1:int)
      {
         super();
         var_197 = param1;
      }
      
      public function setReadOnly() : void
      {
         var_136 = true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function set x(param1:Number) : void
      {
         if(!var_136)
         {
            var_25 = param1;
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
      
      public function get dir() : int
      {
         return var_772;
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_136)
         {
            var_772 = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return var_1132;
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!var_136)
         {
            var_1132 = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return var_1224;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!var_136)
         {
            var_1224 = param1;
         }
      }
      
      public function get sizeZ() : Number
      {
         return var_2640;
      }
      
      public function set sizeZ(param1:Number) : void
      {
         if(!var_136)
         {
            var_2640 = param1;
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
      
      public function get data() : IStuffData
      {
         return var_24;
      }
      
      public function set data(param1:IStuffData) : void
      {
         if(!var_136)
         {
            var_24 = param1;
         }
      }
      
      public function get staticClass() : String
      {
         return var_4196;
      }
      
      public function set staticClass(param1:String) : void
      {
         if(!var_136)
         {
            var_4196 = param1;
         }
      }
      
      public function get extra() : int
      {
         return var_3221;
      }
      
      public function set extra(param1:int) : void
      {
         if(!var_136)
         {
            var_3221 = param1;
         }
      }
      
      public function get expiryTime() : int
      {
         return _expiryTime;
      }
      
      public function set expiryTime(param1:int) : void
      {
         if(!var_136)
         {
            _expiryTime = param1;
         }
      }
      
      public function get usagePolicy() : int
      {
         return var_4056;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         var_4056 = param1;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_1820 = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get trustedSender() : Boolean
      {
         return var_2271;
      }
      
      public function set trustedSender(param1:Boolean) : void
      {
         var_2271 = param1;
      }
   }
}

