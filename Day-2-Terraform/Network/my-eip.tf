resource "aws_eip" "nat-ip" {
	tags = {
	Name = "elastic-ip-2"
	}
}