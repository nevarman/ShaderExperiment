using UnityEngine;
using System.Collections;

public class ShockShader : MonoBehaviour {
	float counter = 0f;
	bool animate = false;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetButtonDown("Fire1"))
		{
			counter = 0f;
			Ray ray = Camera.main.ScreenPointToRay (Input.mousePosition); 
			RaycastHit hit ;
			if (Physics.Raycast (ray,out hit, Mathf.Infinity)) 
			{
				if(hit.collider.gameObject == gameObject)
				{
					Vector3 pos = new Vector3(hit.point.x-transform.position.x+0.5f,hit.point.y-transform.position.y+0.5f,0f);
					renderer.material.SetVector("_Center",new Vector4(pos.x,pos.y,0f,0f));
					renderer.material.SetFloat("_WaveTime",0f);
					animate = true;
				}
			}

		}
		if(animate)
		{
			if(counter < 1.5f)
			{
				counter += Time.deltaTime;
				renderer.material.SetFloat("_WaveTime",counter);
				return;
			}
			animate = false;
		}
	}
}
