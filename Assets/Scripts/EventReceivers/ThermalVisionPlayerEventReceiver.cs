using UnityEngine;
using System.Collections;

public class ThermalVisionPlayerEventReceiver : MonoBehaviour {
   // public string materialEmissionProperty = "_EmissionColor";
	private Material m_Material;
//	private Shader _initShader,_unlit;
	void Start()
	{
		m_Material = GetComponent<Renderer>().material;
//		_initShader = m_Material.shader;
//		_unlit = Shader.Find("Unlit/Texture");
	}
	// Use this for initialization
	void OnEnable () {
		ThermalVision.onThermalVisionEnabled+= OnThermalModeInit;
		HeatVision.onHeatVisionEnabled+= OnThermalMode2Init;
	}
	
	// Update is called once per frame
	void OnDisable () {
		ThermalVision.onThermalVisionEnabled-= OnThermalModeInit;
		HeatVision.onHeatVisionEnabled-= OnThermalMode2Init;
	}

	void OnThermalModeInit (bool enabled)
	{
        //if(m_Material.shader.name != "Custom/ThermalVision-Player")
        //    return;
		if(enabled)
		{
            //m_Material.SetFloat(materialEmissionProperty,1f);
            m_Material.SetColor("_EmissionColor", Color.white*5f);
		}
		else 
		{
            //m_Material.SetFloat(materialEmissionProperty,0f);
            m_Material.SetColor("_EmissionColor", Color.black);
		}
	}

	void OnThermalMode2Init (bool enabled)
	{
        //if(m_Material.shader.name != "Custom/ThermalVision-Player")
        //    return;
		if(enabled)
		{
            //m_Material.SetFloat(materialEmissionProperty,.4f);
            m_Material.SetColor("_EmissionColor", Color.white*5f);
		}
		else 
		{
            //m_Material.SetFloat(materialEmissionProperty,0f);
            m_Material.SetColor("_EmissionColor", Color.black);
		}
	}
}
