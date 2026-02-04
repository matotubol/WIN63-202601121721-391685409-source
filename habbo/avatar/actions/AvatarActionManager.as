package com.sulake.habbo.avatar.actions
{
   import com.sulake.core.assets.class_40;
   import flash.utils.Dictionary;
   
   public class AvatarActionManager
   {
      
      private var _assets:class_40;
      
      private var var_289:Dictionary;
      
      private var _defaultAction:ActionDefinition;
      
      private var var_1679:ActionDefinition;
      
      public function AvatarActionManager(param1:class_40, param2:XML)
      {
         super();
         _assets = param1;
         var_289 = new Dictionary();
         updateActions(param2);
      }
      
      public function updateActions(param1:XML) : void
      {
         var _loc4_:String = null;
         for each(var _loc2_ in param1.action)
         {
            _loc4_ = String(_loc2_.@state);
            if(_loc4_ != "")
            {
               var _loc3_:ActionDefinition = new ActionDefinition(_loc2_);
               var_289[_loc4_] = null;
            }
         }
         parseActionOffsets();
      }
      
      private function parseActionOffsets() : void
      {
         var _loc9_:* = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         for each(_loc9_ in var_289)
         {
            _loc3_ = _loc9_.state;
            if(_assets.hasAsset("action_offset_" + _loc3_))
            {
               var _loc7_:XML = _assets.getAssetByName("action_offset_" + _loc3_).content as XML;
               for each(var _loc2_ in null.offset)
               {
                  var _loc6_:String = String(_loc2_.@size);
                  var _loc10_:int = parseInt(_loc2_.@direction);
                  var _loc1_:int = parseInt(_loc2_.@x);
                  var _loc5_:int = parseInt(_loc2_.@y);
                  _loc4_ = Number(_loc2_.@z);
                  _loc9_.setOffsets(null,0,new Array(0,0,_loc4_));
               }
            }
         }
      }
      
      public function getActionDefinition(param1:String) : ActionDefinition
      {
         for each(var _loc2_ in var_289)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getActionDefinitionWithState(param1:String) : ActionDefinition
      {
         return var_289[param1];
      }
      
      public function getDefaultAction() : ActionDefinition
      {
         if(_defaultAction)
         {
            return _defaultAction;
         }
         for each(var _loc1_ in var_289)
         {
            if(_loc1_.isDefault)
            {
               _defaultAction = _loc1_;
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getDefaultLayAction() : ActionDefinition
      {
         if(var_1679)
         {
            return var_1679;
         }
         var_1679 = getDefaultAction().copy();
         var_1679.setGeometryType("horizontal");
         var_1679.setState("lay");
         var_1679.setAssetPartDefinition("lay");
         return var_1679;
      }
      
      public function getCanvasOffsets(param1:Array, param2:String, param3:int) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:ActiveActionData = null;
         var _loc7_:ActionDefinition = null;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = param1[_loc6_] as ActiveActionData;
            _loc7_ = var_289[_loc5_.actionType] as ActionDefinition;
            if(_loc7_ != null && _loc7_.getOffsets(param2,param3) != null)
            {
               _loc4_ = _loc7_.getOffsets(param2,param3);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function sortActions(param1:Array) : Array
      {
         var _loc4_:ActionDefinition = null;
         param1 = filterActions(param1);
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            _loc4_ = var_289[_loc3_.actionType];
            if(_loc4_ != null)
            {
               _loc3_.definition = _loc4_;
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(orderByPrecedence);
         return _loc2_;
      }
      
      private function filterActions(param1:Array) : Array
      {
         var _loc3_:ActiveActionData = null;
         var _loc7_:ActionDefinition = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Array = [];
         var _loc6_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as ActiveActionData;
            _loc7_ = var_289[_loc3_.actionType] as ActionDefinition;
            if(_loc7_ != null)
            {
               _loc6_ = _loc6_.concat(_loc7_.getPrevents(_loc3_.actionParameter));
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as ActiveActionData;
            _loc5_ = _loc3_.actionType;
            if(_loc3_.actionType == "fx")
            {
               _loc5_ += "." + _loc3_.actionParameter;
            }
            if(_loc6_.indexOf(_loc5_) == -1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function orderByPrecedence(param1:class_2501, param2:class_2501) : Number
      {
         var _loc3_:Number = param1.definition.precedence;
         var _loc4_:Number = param2.definition.precedence;
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         return 0;
      }
   }
}

