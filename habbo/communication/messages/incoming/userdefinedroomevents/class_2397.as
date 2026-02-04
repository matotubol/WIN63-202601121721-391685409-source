package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.WiredContext;
   
   [SecureSWF(rename="true")]
   public class class_2397
   {
      
      private var var_4130:int;
      
      private var var_2620:Array = [];
      
      private var _stuffIds2:Array = [];
      
      private var var_197:int;
      
      private var var_2186:String;
      
      private var _intParams:Array = [];
      
      private var var_2226:Array = [];
      
      private var var_4261:int;
      
      private var var_3602:int;
      
      private var var_2655:Array = [];
      
      private var var_2324:Array = [];
      
      private var var_4506:Boolean;
      
      private var var_3779:InputSourcesConf;
      
      private var var_4604:Boolean;
      
      private var var_5127:WiredContext;
      
      private var var_3576:Array = [];
      
      public function class_2397(param1:IMessageDataWrapper)
      {
         super();
         var_4130 = param1.readInteger();
         var _loc9_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(0 < _loc9_)
         {
            var _loc2_:int = param1.readInteger();
            var_2620.push(0);
            _loc7_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc3_)
         {
            var _loc10_:int = param1.readInteger();
            _stuffIds2.push(0);
            _loc7_++;
         }
         var_4261 = param1.readInteger();
         var_197 = param1.readInteger();
         var_2186 = param1.readString();
         var _loc4_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc4_)
         {
            _intParams.push(param1.readInteger());
            _loc7_++;
         }
         var _loc6_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc6_)
         {
            var_2226.push(param1.readString());
            _loc7_++;
         }
         var _loc5_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc5_)
         {
            var_2655.push(param1.readInteger());
            _loc7_++;
         }
         var _loc11_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc11_)
         {
            var_2324.push(param1.readInteger());
            _loc7_++;
         }
         var_3602 = param1.readInteger();
         readDefinitionSpecifics(param1);
         var_4506 = param1.readBoolean();
         var_3779 = new InputSourcesConf(param1);
         var_4604 = param1.readBoolean();
         readTypeSpecifics(param1);
         var_5127 = new WiredContext(param1);
         var _loc8_:int = param1.readInteger();
         _loc7_ = 0;
         while(0 < _loc8_)
         {
            var_3576.push(param1.readInteger());
            _loc7_++;
         }
      }
      
      public function get furniLimit() : int
      {
         return var_4130;
      }
      
      public function get stuffIds() : Array
      {
         return var_2620;
      }
      
      public function set stuffIds(param1:Array) : void
      {
         var_2620 = param1;
      }
      
      public function get stuffIds2() : Array
      {
         return _stuffIds2;
      }
      
      public function set stuffIds2(param1:Array) : void
      {
         _stuffIds2 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get stringParam() : String
      {
         return var_2186;
      }
      
      public function set stringParam(param1:String) : void
      {
         var_2186 = param1;
      }
      
      public function get intParams() : Array
      {
         return _intParams;
      }
      
      public function set intParams(param1:Array) : void
      {
         _intParams = param1;
      }
      
      public function get variableIds() : Array
      {
         return var_2226;
      }
      
      public function set variableIds(param1:Array) : void
      {
         var_2226 = param1;
      }
      
      public function get furniSourceTypes() : Array
      {
         return var_2655;
      }
      
      public function set furniSourceTypes(param1:Array) : void
      {
         var_2655 = param1;
      }
      
      public function get userSourceTypes() : Array
      {
         return var_2324;
      }
      
      public function set userSourceTypes(param1:Array) : void
      {
         var_2324 = param1;
      }
      
      public function get advancedMode() : Boolean
      {
         return var_4506;
      }
      
      public function get inputSourcesConf() : InputSourcesConf
      {
         return var_3779;
      }
      
      public function get code() : int
      {
         return var_3602;
      }
      
      public function get stuffTypeId() : int
      {
         return var_4261;
      }
      
      public function getBoolean(param1:int) : Boolean
      {
         return _intParams[param1] == 1;
      }
      
      public function getString(param1:int = -1, param2:String = "\t") : String
      {
         if(param1 == -1)
         {
            return var_2186;
         }
         var _loc3_:Array = var_2186.split(param2);
         return _loc3_.length > param1 ? _loc3_[param1] : "";
      }
      
      public function getInt(param1:int) : int
      {
         return _intParams[param1];
      }
      
      public function get allowWallFurni() : Boolean
      {
         return var_4604;
      }
      
      public function get wiredContext() : WiredContext
      {
         return var_5127;
      }
      
      public function get defaultIntParams() : Array
      {
         return var_3576;
      }
      
      protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
      }
      
      protected function readTypeSpecifics(param1:IMessageDataWrapper) : void
      {
      }
      
      public function get usingCustomInputSources() : Boolean
      {
         return var_3779.isUsingAdvancedSettings(furniSourceTypes,userSourceTypes);
      }
   }
}

