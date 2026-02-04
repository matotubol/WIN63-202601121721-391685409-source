package com.sulake.habbo.avatar.actions
{
   import com.sulake.core.utils.class_55;
   import flash.utils.Dictionary;
   
   public class ActionDefinition implements class_2768
   {
      
      private var var_197:String;
      
      private var var_61:String;
      
      private var var_3063:int;
      
      private var var_2832:String;
      
      private var var_2054:String;
      
      private var var_2897:String;
      
      private var var_843:String;
      
      private var _isMain:Boolean = false;
      
      private var _isDefault:Boolean = false;
      
      private var var_3377:Boolean = false;
      
      private var var_3278:Boolean = false;
      
      private var var_2010:Array = [];
      
      private var var_2328:Boolean;
      
      private var var_721:class_55;
      
      private var var_57:Dictionary = new Dictionary();
      
      private var _params:Dictionary = new Dictionary();
      
      private var var_3002:String = "";
      
      public function ActionDefinition(param1:XML = null)
      {
         super();
         if(param1 != null)
         {
            createFromXml(param1);
         }
      }
      
      private function createFromXml(param1:XML) : void
      {
         var_197 = String(param1.@id);
         var_61 = String(param1.@state);
         var_3063 = parseInt(param1.@precedence);
         var_2832 = String(param1.@activepartset);
         var_2054 = String(param1.@assetpartdefinition);
         var_2897 = String(param1.@lay);
         var_843 = String(param1.@geometrytype);
         _isMain = Boolean(parseInt(param1.@main));
         _isDefault = Boolean(parseInt(param1.@isdefault));
         var_3377 = Boolean(parseInt(param1.@animation));
         var_3278 = param1.@startfromframezero == "true";
         var_2328 = param1.@preventheadturn == "true";
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            var_2010 = _loc3_.split(",");
         }
         for each(var _loc2_ in param1.param)
         {
            var _loc6_:String = String(_loc2_.@id);
            var _loc7_:String = String(_loc2_.@value);
            _params[null] = null;
         }
         for each(var _loc5_ in param1.type)
         {
            var _loc4_:String = String(_loc5_.@id);
            var_57[null] = new ActionType(_loc5_);
         }
      }
      
      public function setOffsets(param1:String, param2:int, param3:Array) : void
      {
         if(var_721 == null)
         {
            var_721 = new class_55();
         }
         if(var_721.getValue(param1) == null)
         {
            var_721.add(param1,new class_55());
         }
         var _loc4_:class_55 = var_721.getValue(param1);
         _loc4_.add(param2,param3);
      }
      
      public function getOffsets(param1:String, param2:int) : Array
      {
         if(var_721 == null)
         {
            return null;
         }
         var _loc3_:class_55 = var_721.getValue(param1) as class_55;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2) as Array;
      }
      
      public function getParameterValue(param1:String) : String
      {
         if(param1 == "")
         {
            return "";
         }
         var _loc2_:String = _params[param1];
         if(_loc2_ == null)
         {
            _loc2_ = var_3002;
         }
         return _loc2_;
      }
      
      private function getTypePrevents(param1:String) : Array
      {
         if(param1 == "")
         {
            return [];
         }
         var _loc2_:ActionType = var_57[param1];
         if(_loc2_ != null)
         {
            return _loc2_.prevents;
         }
         return [];
      }
      
      public function toString() : String
      {
         return "[ActionDefinition]\nid:           " + id + "\n" + "state:        " + state + "\n" + "main:         " + isMain + "\n" + "default:      " + isDefault + "\n" + "geometry:     " + state + "\n" + "precedence:   " + precedence + "\n" + "activepartset:" + activePartSet + "\n" + "activepartdef:" + assetPartDefinition + "";
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get state() : String
      {
         return var_61;
      }
      
      public function get precedence() : int
      {
         return var_3063;
      }
      
      public function get activePartSet() : String
      {
         return var_2832;
      }
      
      public function get isMain() : Boolean
      {
         return _isMain;
      }
      
      public function get isDefault() : Boolean
      {
         return _isDefault;
      }
      
      public function get assetPartDefinition() : String
      {
         return var_2054;
      }
      
      public function get lay() : String
      {
         return var_2897;
      }
      
      public function get geometryType() : String
      {
         return var_843;
      }
      
      public function get isAnimation() : Boolean
      {
         return var_3377;
      }
      
      public function getPrevents(param1:String = "") : Array
      {
         return var_2010.concat(getTypePrevents(param1));
      }
      
      public function getPreventHeadTurn(param1:String = "") : Boolean
      {
         if(param1 == "")
         {
            return var_2328;
         }
         var _loc2_:ActionType = var_57[param1];
         if(_loc2_ != null)
         {
            return _loc2_.preventHeadTurn;
         }
         return var_2328;
      }
      
      public function isAnimated(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return true;
         }
         var _loc2_:ActionType = var_57[param1];
         if(_loc2_ != null)
         {
            return _loc2_.isAnimated;
         }
         return true;
      }
      
      public function get startFromFrameZero() : Boolean
      {
         return var_3278;
      }
      
      public function get params() : Dictionary
      {
         return _params;
      }
      
      public function setGeometryType(param1:String) : void
      {
         var_843 = param1;
      }
      
      public function setState(param1:String) : void
      {
         var_61 = param1;
      }
      
      public function setAssetPartDefinition(param1:String) : void
      {
         var_2054 = param1;
      }
      
      public function copy() : ActionDefinition
      {
         var _loc1_:ActionDefinition = new ActionDefinition();
         _loc1_.var_197 = var_197;
         _loc1_.var_61 = var_61;
         _loc1_.var_3063 = var_3063;
         _loc1_.var_2832 = var_2832;
         _loc1_.var_2054 = var_2054;
         _loc1_.var_2897 = var_2897;
         _loc1_.var_843 = var_843;
         _loc1_._isMain = _isMain;
         _loc1_._isDefault = _isDefault;
         _loc1_.var_3377 = var_3377;
         _loc1_.var_3278 = var_3278;
         _loc1_.var_2010 = var_2010;
         _loc1_.var_2328 = var_2328;
         _loc1_.var_721 = var_721;
         _loc1_.var_57 = var_57;
         _loc1_._params = _params;
         _loc1_.var_3002 = var_3002;
         return _loc1_;
      }
   }
}

