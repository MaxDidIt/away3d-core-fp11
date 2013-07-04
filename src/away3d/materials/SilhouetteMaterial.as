package away3d.materials 
{
	import away3d.arcane;
	import away3d.materials.passes.SilhouetteMaterialPass;
	import flash.display3D.Context3D;
	
	use namespace arcane;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SilhouetteMaterial extends ColorMaterial 
	{
		private var _silhouettePass:SilhouetteMaterialPass;
		
		/**
		 * Creates a new ColorMaterial object.
		 * @param color The material's diffuse surface color.
		 * @param alpha The material's surface alpha.
		 */
		public function SilhouetteMaterial(color : uint = 0xcccccc, silhouetteColor:uint = 0x0099FF, alpha : Number = 1, silhouetteAlpha : Number = 0.5) 
		{
			super(color, alpha);
			
			_silhouettePass = new SilhouetteMaterialPass(this);
			_silhouettePass.diffuseMethod.diffuseColor = silhouetteColor;
			
			this.silhouetteAlpha = silhouetteAlpha;
			
			clearPasses();
			addPass(_silhouettePass);
			addPass(_screenPass);
			
			_renderOrderId = 1;
		}
		
		/**
		 * The color of the silhouette which is rendered behind obstructing objects.
		 */
		public function get silhouetteColor():uint 
		{
			return _silhouettePass.diffuseMethod.diffuseColor;
		}
		
		public function set silhouetteColor(value:uint):void 
		{
			_silhouettePass.diffuseMethod.diffuseColor = value;
		}
		
		/**
		 * The alpha of the silhouette which is rendered behind obstructing objects.
		 */
		public function get silhouetteAlpha() : Number
		{
			return _silhouettePass.diffuseMethod.diffuseAlpha;
		}

		public function set silhouetteAlpha(value : Number) : void
		{
			if (value > 1) value = 1;
			else if (value < 0) value = 0;
			_silhouettePass.diffuseMethod.diffuseAlpha = value;
		}
		
		override public function get requiresBlending():Boolean 
		{
			return true;
		}
		
		override arcane function updateMaterial(context:Context3D):void
		{
			if (_screenPass._passesDirty)
			{
				clearPasses();
				if (_screenPass._passes)
				{
					var len:uint = _screenPass._passes.length;
					for (var i:uint = 0; i < len; ++i)
						addPass(_screenPass._passes[i]);
				}
				
				addPass(_screenPass);
				addPass(_silhouettePass);
				_screenPass._passesDirty = false;
			}
		}
		
	}

}