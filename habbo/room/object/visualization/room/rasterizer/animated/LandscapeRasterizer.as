package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterial;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.class_2119;
   import flash.display.BitmapData;
   
   public class LandscapeRasterizer extends PlaneRasterizer
   {
      
      private static const UPDATE_INTERVAL:int = 500;
      
      private var _landscapeWidth:int = 0;
      
      private var var_5252:int = 0;
      
      public function LandscapeRasterizer()
      {
         super();
      }
      
      override public function initializeDimensions(param1:int, param2:int) : Boolean
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         _landscapeWidth = param1;
         var_5252 = param2;
         return true;
      }
      
      override protected function initializePlanes() : void
      {
         if(data == null)
         {
            return;
         }
         var _loc1_:XMLList = data.landscapes;
         if(_loc1_.length() > 0)
         {
            parseLandscapes(_loc1_[0]);
         }
      }
      
      private function parseLandscapes(param1:XML) : void
      {
         var _loc23_:int = 0;
         var _loc29_:XML = null;
         var _loc14_:String = null;
         var _loc11_:XMLList = null;
         var _loc38_:class_3968 = null;
         var _loc24_:int = 0;
         var _loc26_:XML = null;
         var _loc32_:int = 0;
         var _loc19_:String = null;
         var _loc13_:String = null;
         var _loc12_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc17_:int = 0;
         var _loc22_:PlaneVisualization = null;
         var _loc25_:int = 0;
         var _loc39_:XML = null;
         var _loc8_:XML = null;
         var _loc33_:PlaneMaterial = null;
         var _loc7_:int = 0;
         var _loc27_:String = null;
         var _loc36_:String = null;
         var _loc18_:int = 0;
         var _loc6_:String = null;
         var _loc3_:* = 0;
         var _loc9_:String = null;
         var _loc37_:XMLList = null;
         var _loc4_:XML = null;
         var _loc28_:int = 0;
         var _loc16_:XML = null;
         var _loc30_:int = 0;
         var _loc10_:String = null;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc20_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Array = ["id","assetId"];
         var _loc2_:int = Math.random() * 654321;
         var _loc15_:XMLList = param1.landscape;
         _loc23_ = 0;
         while(_loc23_ < _loc15_.length())
         {
            _loc29_ = _loc15_[_loc23_];
            if(class_2119.checkRequiredAttributes(_loc29_,["id"]))
            {
               _loc14_ = _loc29_.@id;
               _loc11_ = _loc29_.animatedVisualization;
               _loc38_ = new class_3968();
               _loc24_ = 0;
               while(_loc24_ < _loc11_.length())
               {
                  _loc26_ = _loc11_[_loc24_];
                  if(class_2119.checkRequiredAttributes(_loc26_,["size"]))
                  {
                     _loc32_ = parseInt(_loc26_.@size);
                     _loc19_ = _loc26_.@horizontalAngle;
                     _loc13_ = _loc26_.@verticalAngle;
                     _loc12_ = 45;
                     if(_loc19_ != "")
                     {
                        _loc12_ = parseFloat(_loc19_);
                     }
                     _loc31_ = 30;
                     if(_loc13_ != "")
                     {
                        _loc31_ = parseFloat(_loc13_);
                     }
                     _loc17_ = _loc26_.visualizationLayer.length() + _loc26_.animationLayer.length();
                     _loc22_ = _loc38_.createPlaneVisualization(_loc32_,_loc17_,getGeometry(_loc32_,_loc12_,_loc31_));
                     if(_loc22_ != null)
                     {
                        Randomizer.setSeed(_loc2_);
                        _loc25_ = 0;
                        while(_loc25_ < _loc26_.children().length())
                        {
                           _loc39_ = _loc26_.children()[_loc25_];
                           if(_loc39_.name() == "visualizationLayer")
                           {
                              _loc8_ = _loc39_;
                              _loc33_ = null;
                              _loc7_ = 1;
                              if(class_2119.checkRequiredAttributes(_loc8_,["materialId"]))
                              {
                                 _loc27_ = _loc8_.@materialId;
                                 _loc33_ = getMaterial(_loc27_);
                              }
                              _loc36_ = _loc8_.@offset;
                              _loc18_ = 0;
                              if(_loc36_.length > 0)
                              {
                                 _loc18_ = parseInt(_loc36_);
                              }
                              _loc6_ = _loc8_.@color;
                              _loc3_ = 16777215;
                              if(_loc6_.length > 0)
                              {
                                 _loc3_ = parseInt(_loc6_);
                              }
                              _loc9_ = _loc8_.@align;
                              if(_loc9_ == "bottom")
                              {
                                 _loc7_ = 2;
                              }
                              else if(_loc9_ == "top")
                              {
                                 _loc7_ = 1;
                              }
                              _loc22_.setLayer(_loc25_,_loc33_,_loc3_,_loc7_,_loc18_);
                           }
                           else if(_loc39_.name() == "animationLayer")
                           {
                              _loc37_ = _loc39_.animationItem;
                              _loc4_ = <animation />;
                              _loc28_ = 0;
                              while(_loc28_ < _loc37_.length())
                              {
                                 _loc16_ = _loc37_[_loc28_] as XML;
                                 if(_loc16_ != null)
                                 {
                                    if(class_2119.checkRequiredAttributes(_loc16_,_loc5_))
                                    {
                                       _loc30_ = parseInt(_loc16_.@id);
                                       _loc10_ = _loc16_.@assetId;
                                       _loc34_ = 0;
                                       _loc35_ = 0;
                                       _loc34_ = getCoordinateValue(_loc16_.@x,_loc16_.@randomX);
                                       _loc35_ = getCoordinateValue(_loc16_.@y,_loc16_.@randomY);
                                       _loc21_ = 0;
                                       _loc20_ = 0;
                                       _loc21_ = parseFloat(_loc16_.@speedX);
                                       _loc20_ = parseFloat(_loc16_.@speedY);
                                       _loc4_.appendChild(<item x={_loc34_} y={_loc35_} speedX={_loc21_} speedY={_loc20_} asset={_loc10_}/> );
                                    }
                                 }
                                 _loc28_++;
                              }
                              _loc22_.setAnimationLayer(_loc25_,_loc4_,assetCollection);
                           }
                           _loc25_++;
                        }
                     }
                  }
                  _loc24_++;
               }
               if(!addPlane(_loc14_,_loc38_))
               {
                  _loc38_.dispose();
               }
            }
            _loc23_++;
         }
      }
      
      private function getCoordinateValue(param1:String, param2:String) : Number
      {
         var _loc4_:Number = NaN;
         var _loc3_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = 0;
         if(param1.length > 0)
         {
            if(param1.charAt(param1.length - 1) == "%")
            {
               param1 = param1.substr(0,param1.length - 1);
               _loc6_ = parseFloat(param1) / 100;
            }
         }
         if(param2.length > 0)
         {
            _loc4_ = 10000;
            _loc3_ = Randomizer.getValues(1,0,_loc4_);
            _loc5_ = _loc3_[0] / _loc4_;
            if(param2.charAt(param2.length - 1) == "%")
            {
               param2 = param2.substr(0,param2.length - 1);
               _loc6_ += _loc5_ * parseFloat(param2) / 100;
            }
         }
         return _loc6_;
      }
      
      override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         var _loc15_:class_3968 = getPlane(param2) as class_3968;
         if(_loc15_ == null)
         {
            _loc15_ = getPlane("default") as class_3968;
         }
         if(_loc15_ == null)
         {
            return null;
         }
         if(param1 != null)
         {
            param1.fillRect(param1.rect,16777215);
         }
         var _loc14_:BitmapData = _loc15_.render(param1,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         if(_loc14_ != null && _loc14_ != param1)
         {
            try
            {
               _loc14_ = _loc14_.clone();
            }
            catch(e:Error)
            {
               _loc14_.dispose();
               return null;
            }
         }
         var _loc13_:PlaneBitmapData = null;
         if(!_loc15_.isStatic(param5))
         {
            _loc13_ = new PlaneBitmapData(_loc14_,Math.round(param12 / 500) * 500 + 500);
         }
         else
         {
            _loc13_ = new PlaneBitmapData(_loc14_,-1);
         }
         return _loc13_;
      }
      
      override public function getTextureIdentifier(param1:Number, param2:IVector3d) : String
      {
         if(param2 != null)
         {
            if(param2.x < 0)
            {
               return param1 + "_0";
            }
            return param1 + "_1";
         }
         return super.getTextureIdentifier(param1,param2);
      }
   }
}

