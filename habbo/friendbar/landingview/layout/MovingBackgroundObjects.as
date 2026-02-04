package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.*;
   import flash.events.EventDispatcher;
   
   public class MovingBackgroundObjects implements class_13, class_31
   {
      
      private static const MAX_OBJECTS:int = 20;
      
      private var _landingView:HabboLandingView;
      
      private var var_411:Array = [];
      
      private var var_1091:class_55 = new class_55();
      
      private var name_1:EventDispatcher = new EventDispatcher();
      
      private var var_3726:String = "";
      
      public function MovingBackgroundObjects(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         initializeObjectTypeMapping();
      }
      
      private function initializeObjectTypeMapping() : void
      {
         var_1091.add("line",class_4088.CLASS_LINEAR);
         var_1091.add("spiral",class_4088.CLASS_SPIRAL);
         var_1091.add("animated",class_4088.CLASS_STATIC_ANIMATED);
         var_1091.add("randomwalk",class_4088.CLASS_RANDOM_WALK);
      }
      
      public function dispose() : void
      {
         _landingView = null;
         for each(var _loc1_ in var_411)
         {
            _loc1_.dispose();
         }
         var_411 = null;
         var_1091.reset();
         var_1091 = null;
         name_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:class_1812) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         param1 = class_1812(param1.findChildByName("moving_objects_container"));
         if(param1 == null)
         {
            return;
         }
         if(var_411.length > 0)
         {
            return;
         }
         _loc4_ = 1;
         while(_loc4_ <= 20)
         {
            if(var_3726 == "")
            {
               _loc2_ = _landingView.getProperty("landing.view.bgobject." + _loc4_);
            }
            else
            {
               _loc2_ = _landingView.getProperty("landing.view." + var_3726 + ".bgobject." + _loc4_);
            }
            if(_loc2_ != "")
            {
               var _loc3_:BackgroundObject = getObjectByDataContent(_loc4_,_loc2_,param1);
            }
            _loc4_++;
         }
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in var_411)
         {
            _loc2_.update(param1);
         }
      }
      
      private function getObjectByDataContent(param1:int, param2:String, param3:class_1812) : BackgroundObject
      {
         var _loc6_:String = null;
         var _loc5_:Class = null;
         var _loc4_:Array = param2.split(";");
         if(_loc4_.length >= 2)
         {
            _loc6_ = _loc4_[1];
            _loc5_ = var_1091.getValue(_loc6_);
            if(_loc5_ != null)
            {
               return new _loc5_(param1,param3,name_1,_landingView,param2);
            }
         }
         return null;
      }
      
      public function set timingCode(param1:String) : void
      {
         var_3726 = param1;
      }
   }
}

